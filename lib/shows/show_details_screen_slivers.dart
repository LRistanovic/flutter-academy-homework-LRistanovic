import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'util/review.dart';
import 'util/reviews_provider.dart';
import 'util/show.dart';
import 'widgets/review_widget.dart';
import 'write_review_screen.dart';

class ShowDetailsScreen extends StatelessWidget {
  final Show show;

  const ShowDetailsScreen({required this.show, Key? key}) : super(key: key);

  List<Widget> widgetsFromReviews(List<Review> reviews) {
    List<Widget> widgets = [];
    for (var review in reviews) {
      widgets.add(ReviewWidget(review: review));
    }
    return widgets;
  }

  double averageRating(List<Review> reviews) {
    double sum = 0;
    for (var review in reviews) {
      sum += review.rating;
    }
    return sum / reviews.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => ReviewsProvider(show.id, context),
        child: Consumer<ReviewsProvider>(
          builder: (context, reviewsProvider, _) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(show.name ?? '<no data>'),
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: show.imageUrl != null
                        ? Image.network(
                            show.imageUrl!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            color: Colors.grey.withOpacity(0.8),
                            colorBlendMode: BlendMode.modulate,
                          )
                        : null,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: show.description != null ? Text(show.description!) : null),
                      Container(
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                reviewsProvider.state.when(
                  initial: () => SliverToBoxAdapter(child: Container()),
                  loading: () {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  success: (reviews) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              '${reviews.length} REVIEWS, ${averageRating(reviews)} AVERAGE',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
                            child: RatingBarIndicator(
                              rating: averageRating(reviews),
                              itemBuilder: (context, index) => const Icon(Icons.star, color: Color(0xff52368C)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  failure: (error) {
                    return SliverToBoxAdapter(
                      child: Text(error.toString()),
                    );
                  },
                ),
                reviewsProvider.state.maybeWhen(
                    success: (reviews) => SliverList(
                          delegate: SliverChildListDelegate(
                            widgetsFromReviews(reviews),
                          ),
                        ),
                    failure: (error) => SliverToBoxAdapter(
                          child: Text(error.toString()),
                        ),
                    orElse: () => const SliverToBoxAdapter()),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    // height: 70,
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => WriteReviewScreen(
                            showId: show.id,
                            reviewsProvider: reviewsProvider,
                          ),
                        );
                      },
                      child: const Text('Write a Review'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xff52368C),
                        ),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
