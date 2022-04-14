import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:tv_shows/shows/util/reviews_provider.dart';
import 'package:tv_shows/shows/widgets/review_widget.dart';

import '../util/review.dart';

class ReviewsSectionWidget extends StatefulWidget {
  final ReviewsProvider reviewsProvider;

  const ReviewsSectionWidget({required this.reviewsProvider, Key? key}) : super(key: key);

  @override
  State<ReviewsSectionWidget> createState() => _ReviewsSectionWidgetState();
}

class _ReviewsSectionWidgetState extends State<ReviewsSectionWidget> with SingleTickerProviderStateMixin {
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

  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    startAnimation();
    super.initState();
  }

  void startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.reviewsProvider.state.when(
      initial: () => Container(),
      loading: () => Center(child: Lottie.asset('assets/lottie/tv.json', height: 100)),
      success: (reviews) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeOut),
          ),
          child: Column(
            children: [
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
              Column(
                children: widgetsFromReviews(reviews),
              ),
            ],
          ),
        );
      },
      failure: (error) => Text(error.toString()),
    );
  }
}
