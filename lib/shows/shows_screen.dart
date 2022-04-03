import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        title: const Text(
          'Shows',
          style: TextStyle(fontSize: 30),
        ),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: ChangeNotifierProvider<ShowsProvider>(
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
                    // SingleChildScrollView(
                    //   child: Column(
                    //     children: widgetsFromShows(shows),
                    //   ),
                    // ),
                    : const NoShowsWidget(),
                failure: (error) => const NoShowsWidget());
          },
        ),
      ),
    );
  }
}

class NoShowsWidget extends StatelessWidget {
  const NoShowsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(margin: const EdgeInsets.all(20), child: SvgPicture.asset('assets/images/shows/no_shows.svg')),
        const Text('Your shows are not showing. Get it?', style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
