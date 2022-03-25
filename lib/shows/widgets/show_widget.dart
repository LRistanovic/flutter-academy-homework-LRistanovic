import 'package:flutter/material.dart';

import '../show_details_screen.dart';
import '../util/show.dart';

class ShowWidget extends StatelessWidget {
  final Show show;

  const ShowWidget({
    Key? key,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 6, 20, 6),
      height: 250,
      child: OutlinedButton(
        onPressed: () {
          final route = MaterialPageRoute(builder: (context) => ShowDetailsScreen(show: show));
          Navigator.of(context).push(route);
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                show.imageUrl,
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(show.name,
                            //overflow: TextOverflow.fade,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 17))),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(show.description,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis)))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
