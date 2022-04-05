// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tv_shows/shows/write_review_screen.dart';
//
// import 'util/review.dart';
// import 'util/reviews_provider.dart';
// import 'util/show.dart';
// import 'widgets/review_widget.dart';
// import 'write_review_screen.dart';
//
// class ShowDetailsScreen extends StatelessWidget {
//   final Show show;
//
//   const ShowDetailsScreen({Key? key, required this.show}) : super(key: key);
//
//   List<Widget> widgetsFromReviews(List<Review> reviews) {
//     List<Widget> widgets = [];
//     for (var review in reviews) {
//       widgets.add(ReviewWidget(review: review));
//     }
//     return widgets;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(show.name ?? '<no data>'),
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//         ),
//         body: ChangeNotifierProvider(
//           create: (context) => ReviewsProvider(show.id, context),
//           child: Container(
//             padding: const EdgeInsets.only(left: 15, right: 15),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Container(
//                           margin: const EdgeInsets.only(top: 15),
//                           child: show.imageUrl != null ? Image.network(show.imageUrl!) : Container(),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(top: 25, bottom: 15),
//                           child: Text(
//                             show.description ?? '',
//                             style: const TextStyle(fontSize: 16),
//                           ),
//                         ),
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           margin: const EdgeInsets.only(top: 20, bottom: 15),
//                           child: const Text(
//                             'Reviews',
//                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Consumer<ReviewsProvider>(
//                           builder: (context, reviewsProvider, _) {
//                             return reviewsProvider.state.when(
//                               initial: () => Container(),
//                               loading: () => const CircularProgressIndicator(),
//                               success: (reviews) => reviews.length != 0
//                                   ? Column(
//                                       children: widgetsFromReviews(reviews),
//                                     )
//                                   : const NoReviewsWidget(),
//                               failure: (error) => Text(error.toString()),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(top: 15, bottom: 15),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       showModalBottomSheet(
//                         context: context,
//                         builder: (context) => WriteReviewScreen(
//                           showId: show.id,
//                           reviewsProvider: reviewsProvider,
//                         ),
//                       );
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       width: double.infinity,
//                       child: const Text('Write a Review'),
//                     ),
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                         const Color(0xff52368C),
//                       ),
//                       foregroundColor: MaterialStateProperty.all(Colors.white),
//                       shape: MaterialStateProperty.all(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
//
// class NoReviewsWidget extends StatelessWidget {
//   const NoReviewsWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       child: const Text('No reviews yet.'),
//     );
//   }
// }
