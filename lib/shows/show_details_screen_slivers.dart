import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/shows/widgets/description_widget.dart';
import 'package:tv_shows/shows/widgets/reviews_section_widget.dart';
import 'package:tv_shows/shows/widgets/write_review_button_widget.dart';

import 'util/reviews_provider.dart';
import 'util/show.dart';

class ShowDetailsScreen extends StatelessWidget {
  final Show show;

  const ShowDetailsScreen({required this.show, Key? key}) : super(key: key);

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
                        ? Hero(
                            tag: show.id,
                            child: Image.network(
                              show.imageUrl!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              color: Colors.grey.withOpacity(0.8),
                              colorBlendMode: BlendMode.modulate,
                            ),
                          )
                        : null,
                  ),
                ),
                SliverToBoxAdapter(
                  child: DescriptionWidget(show: show),
                ),
                SliverToBoxAdapter(
                  child: ReviewsSectionWidget(reviewsProvider: reviewsProvider),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: WriteReviewButtonWidget(
                    show: show,
                    reviewsProvider: reviewsProvider,
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
