import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/common/listener.dart';
import 'package:tv_shows/login/login/login_screen.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/networking/request_provider/request_state.dart';
import 'package:tv_shows/shows/util/user_profile_provider.dart';
import 'package:tv_shows/shows/widgets/profile_picture_widget.dart';

import '../networking/storage_repository.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProfileProvider(context.read<NetworkRepository>()),
      builder: (context, _) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ProfilePictureWidget(context.watch<UserProfileProvider>()),
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
                key: const ValueKey('update button'),
                onPressed: () {
                  context.read<UserProfileProvider>().didSelectUpdateButton();
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
                  child: context.watch<UserProfileProvider>().state.maybeWhen(
                        loading: () => const CircularProgressIndicator(),
                        orElse: () => const Text('Update'),
                      ),
                ),
              ),
            ),
            ProviderListener<UserProfileProvider>(
              listener: (context, userProfileProvider) async {
                if (userProfileProvider.state is RequestStateSuccess) {
                  await userProfileProvider.pfpController?.forward();
                  await userProfileProvider.pfpController?.reverse();
                  Navigator.of(context).pop();
                } else if (userProfileProvider.state is RequestStateFailure) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: SingleChildScrollView(
                          child: Text('Something went wrong: ${userProfileProvider.state.maybeWhen(
                            failure: (error) => error.toString(),
                            orElse: () => 'nothing',
                          )}'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Dismiss'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Container(),
            ),
            ElevatedButton(
              key: const Key('logout button'),
              onPressed: () {
                context.read<StorageRepository>().deleteData();

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
