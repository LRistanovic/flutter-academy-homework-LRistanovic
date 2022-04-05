import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/login/login/login_screen.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/shows/util/user_profile_provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  Future<void> pickImage(UserProfileProvider userProfileProvider) async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) {
      return;
    }

    userProfileProvider.didUpdateProfilePicture(imageFile.path, userProfileProvider.newEmail);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProfileProvider(context.read<NetworkRepository>()),
      builder: (context, _) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  const CircleBorder(),
                ),
              ),
              onPressed: () {
                pickImage(context.read<UserProfileProvider>());
              },
              child: context.read<UserProfileProvider>().user.imageUrl == null
                  ? Image.asset(
                      'assets/default-pfp.png',
                      width: 80,
                      height: 80,
                    )
                  : Image.network(
                      context.read<UserProfileProvider>().user.imageUrl!,
                      width: 80,
                      height: 80,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
              child: TextField(
                onChanged: (newVal) => context.read<UserProfileProvider>().newEmail = newVal,
                controller: TextEditingController(text: context.read<UserProfileProvider>().user.email),
                style: const TextStyle(
                  color: Color(0xff52368C),
                ),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff52368C), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff52368C), width: 2),
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xff52368C)),
                  hoverColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: OutlinedButton(
                onPressed: () {
                  context
                      .read<UserProfileProvider>()
                      .didSelectUpdateButton(context.read<UserProfileProvider>().newEmail);
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(const Color(0xff52368C)),
                  side: MaterialStateProperty.all(const BorderSide(color: Color(0xff52368C))),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text('Update'),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<NetworkRepository>().storageRepository.deleteData();

                final route = MaterialPageRoute(builder: (context) => const LoginScreen());
                Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xff52368C)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              ),
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
