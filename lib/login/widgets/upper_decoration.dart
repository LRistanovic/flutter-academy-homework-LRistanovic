import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpperDecoration extends StatelessWidget {
  const UpperDecoration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 266,
        child: Stack(alignment: Alignment.center, children: [
          Positioned(left: 0, top: 0, child: SvgPicture.asset('assets/images/topleft.svg')),
          Positioned(right: 0, top: 0, child: SvgPicture.asset('assets/images/topright.svg')),
          Positioned(left: 50, top: 150, child: SvgPicture.asset('assets/images/horizontallogo.svg')),
        ]));
  }
}
