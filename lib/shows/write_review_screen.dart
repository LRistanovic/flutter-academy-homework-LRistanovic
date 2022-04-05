import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/common/listener.dart';
import 'package:tv_shows/networking/request_provider/request_state.dart';
import 'package:tv_shows/shows/util/reviews_provider.dart';
import 'package:tv_shows/shows/util/write_review_provider.dart';

class WriteReviewScreen extends StatelessWidget {
  final String showId;
  final ReviewsProvider reviewsProvider;
  const WriteReviewScreen({required this.showId, required this.reviewsProvider, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WriteReviewProvider(showId: showId, reviewsProvider: reviewsProvider),
      child: Consumer<WriteReviewProvider>(
        builder: (context, writeReviewProvider, _) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Write a review',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: RatingBar.builder(
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Color(0xff52368C)),
                  onRatingUpdate: (rating) => writeReviewProvider.rating = rating.round(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  obscureText: false,
                  autocorrect: false,
                  maxLines: 10,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    labelText: 'Comment',
                    labelStyle: TextStyle(color: Colors.grey),
                    hoverColor: Colors.white,
                  ),
                  onChanged: (value) => writeReviewProvider.comment = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xff52368C)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: writeReviewProvider.state.when(
                      initial: () => const Text('Submit'),
                      loading: () => const CircularProgressIndicator(),
                      success: (review) => const Text('Submission successful.'),
                      failure: (error) => Text(error.toString()),
                    ),
                  ),
                  onPressed: () {
                    writeReviewProvider.submittedReview(context);
                  },
                ),
              ),
              ProviderListener<WriteReviewProvider>(
                listener: (context, writeReviewProvider) {
                  if (writeReviewProvider.state is RequestStateSuccess) {
                    Navigator.of(context).pop();
                  }
                },
                child: Container(),
              )
            ],
          );
        },
      ),
    );
  }
}
