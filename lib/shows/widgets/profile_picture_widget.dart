import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/shows/util/user_profile_provider.dart';

class ProfilePictureWidget extends StatefulWidget {
  final UserProfileProvider userProfileProvider;

  const ProfilePictureWidget(this.userProfileProvider, {Key? key}) : super(key: key);

  @override
  State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    widget.userProfileProvider.pfpController = _controller;
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> pickImage(UserProfileProvider userProfileProvider) async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return;
    }
    userProfileProvider.newImage = imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1, end: 1.5).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.easeInOut),
      ),
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const CircleBorder(),
          ),
        ),
        onPressed: () {
          pickImage(widget.userProfileProvider);
        },
        child: ClipOval(
          child: Consumer<UserProfileProvider>(
            builder: (context, userProfileProvider, _) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) => RotationTransition(
                  turns: animation,
                  child: child,
                ),
                child: widget.userProfileProvider.newImagePath != null
                    ? Image.file(
                        File(widget.userProfileProvider.newImagePath!.path),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        key: ValueKey(widget.userProfileProvider.newImagePath!),
                      )
                    : widget.userProfileProvider.user.imageUrl == null
                        ? Image.asset(
                            'assets/default-pfp.png',
                            width: 80,
                            height: 80,
                            key: const ValueKey('default-pfp.png'),
                          )
                        : Image.network(
                            widget.userProfileProvider.user.imageUrl!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            key: ValueKey(widget.userProfileProvider.user.imageUrl!),
                          ),
              );
            },
          ),
        ),
      ),
    );
  }
}
