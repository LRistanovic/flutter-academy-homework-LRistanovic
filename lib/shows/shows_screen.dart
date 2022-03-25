import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'util/shows_provider.dart';
import 'widgets/show_widget.dart';

class ShowsScreen extends StatelessWidget {
  const ShowsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<ShowsProvider>(
        create: (_) => ShowsProvider(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Shows',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Consumer<ShowsProvider>(
                    builder: (context, showsProvider, _) {
                      return OutlinedButton(
                          onPressed: () => {
                                showsProvider.areShowsAvailable
                                    ? showsProvider.areShowsAvailable = false
                                    : showsProvider.areShowsAvailable = true
                              },
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                          child: Text(showsProvider.areShowsAvailable ? 'Hide' : 'Show'));
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer<ShowsProvider>(
                builder: (context, showsProvider, _) {
                  return !showsProvider.areShowsAvailable
                      ? const NoShowsWidget()
                      : SingleChildScrollView(
                          child: Consumer<ShowsProvider>(
                            builder: (context, showsProvider, _) {
                              return Column(
                                  children: showsProvider.shows.map((show) => ShowWidget(show: show)).toList());
                            },
                          ),
                        );
                },
              ),
            ),
          ],
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
