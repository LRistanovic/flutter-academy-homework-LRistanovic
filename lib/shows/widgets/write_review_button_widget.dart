import 'package:flutter/material.dart';
import 'package:tv_shows/shows/util/reviews_provider.dart';
import 'package:tv_shows/shows/util/show.dart';

import '../write_review_screen.dart';

class WriteReviewButtonWidget extends StatefulWidget {
  final Show show;
  final ReviewsProvider reviewsProvider;

  const WriteReviewButtonWidget({required this.show, required this.reviewsProvider, Key? key}) : super(key: key);

  @override
  State<WriteReviewButtonWidget> createState() => _WriteReviewButtonWidgetState();
}

class _WriteReviewButtonWidgetState extends State<WriteReviewButtonWidget> with SingleTickerProviderStateMixin {
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
    await Future.delayed(const Duration(milliseconds: 600));
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.easeOut),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => WriteReviewScreen(
                showId: widget.show.id,
                reviewsProvider: widget.reviewsProvider,
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
    );
  }
}
