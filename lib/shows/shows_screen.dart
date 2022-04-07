import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/networking/network_repository.dart';
import 'package:tv_shows/shows/user_profile_screen.dart';

import 'util/show.dart';
import 'util/shows_provider.dart';
import 'widgets/show_widget.dart';

class ShowsScreen extends StatelessWidget {
  const ShowsScreen({Key? key}) : super(key: key);

  List<Widget> widgetsFromShows(List<Show> shows) {
    List<Widget> widgets = [];
    for (Show show in shows) {
      widgets.add(ShowWidget(show: show));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Shows',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const CircleBorder(),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const UserProfileScreen(),
                    );
                  },
                  child: ClipOval(
                    child: context.read<NetworkRepository>().storageRepository.user?.imageUrl == null
                        ? Image.asset(
                            'assets/default-pfp.png',
                            width: 50,
                            height: 50,
                          )
                        : Image.network(
                            context.read<NetworkRepository>().storageRepository.user!.imageUrl!,
                            width: 50,
                            height: 50,
                          ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            thickness: 1,
          ),
          Expanded(
            child: ChangeNotifierProvider<ShowsProvider>(
              create: (context) => ShowsProvider(context),
              child: Consumer<ShowsProvider>(
                builder: (context, showsProvider, _) {
                  return showsProvider.state.when(
                    initial: () => Container(),
                    loading: () => const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    success: (shows) => shows.length != 0
                        ? ListView(
                            children: widgetsFromShows(shows),
                          )
                        : const NoShowsWidget(),
                    failure: (error) => const NoShowsWidget(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoShowsWidget extends StatelessWidget {
  const NoShowsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(margin: const EdgeInsets.all(20), child: SvgPicture.asset('assets/images/shows/no_shows.svg')),
          const Text('Your shows are not showing. Get it?', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
