import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../util/review.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;

  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(review.imageUrl),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  review.userEmail,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xff52368C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  review.rating.toString(),
                  style: const TextStyle(
                    color: Color(0xff52368C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.star,
                  color: Color(0xff52368C),
                ),
              ],
            ),
          ],
        ),
        Container(
          margin: review.comment != null ? const EdgeInsets.only(top: 20, bottom: 20) : null,
          alignment: Alignment.centerLeft,
          child: Text(review.comment ?? ''),
        ),
      ],
    );
  }
}
