import 'package:flutter/material.dart';

import '../util/review.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;
  final String defaultProfilePicture = 'https://srnet.ca/wp-content/uploads/2017/01/Default-Profile.png';

  const ReviewWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: review.user.imageUrl == null
                        ? const AssetImage('assets/default-pfp.png') as ImageProvider
                        : NetworkImage(review.user.imageUrl!),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    review.user.email,
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
            margin: review.comment != null ? const EdgeInsets.only(top: 20, bottom: 10) : null,
            alignment: Alignment.centerLeft,
            child: Text(review.comment ?? ''),
          ),
          const Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}
