import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'util/reviews_provider.dart';
import 'util/show.dart';
import 'widgets/review_widget.dart';

class ShowDetailsScreen extends StatelessWidget {
  final Show show;

  const ShowDetailsScreen({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(show.name),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: ChangeNotifierProvider(
          create: (context) => ReviewsProvider(),
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: show.imageUrl != null ? Image.asset(show.imageUrl!) : Container(),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 25, bottom: 15),
                          child: Text(
                            show.description ?? '',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 20, bottom: 15),
                          child: const Text(
                            'Reviews',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Consumer<ReviewsProvider>(
                          builder: (context, reviewsProvider, _) {
                            return false // ovdje ide neki check ali nisam siguran koji, neka ga ovako za sad
                                ? const NoReviewsWidget()
                                : Column(
                                    children:
                                        reviewsProvider.reviews.map((review) => ReviewWidget(review: review)).toList());
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: const Text('Write a Review'),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xff52368C),
                      ),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class NoReviewsWidget extends StatelessWidget {
  const NoReviewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Text('No reviews yet.'),
    );
  }
}
