import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpperDecoration1 extends StatelessWidget {
  const UpperDecoration1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 266,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: 0, top: 0, child: SvgPicture.asset('assets/images/topleft.svg')),
          Positioned(right: 0, top: 0, child: SvgPicture.asset('assets/images/topright.svg')),
          Positioned(left: 50, top: 150, child: SvgPicture.asset('assets/images/horizontallogo.svg')),
        ],
      ),
    );
  }
}

class UpperDecoration extends StatefulWidget {
  const UpperDecoration({Key? key}) : super(key: key);

  @override
  State<UpperDecoration> createState() => _UpperDecorationState();
}

class _UpperDecorationState extends State<UpperDecoration> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 266,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(left: 0, top: 0, child: SvgPicture.asset('assets/images/topleft.svg')),
          Positioned(right: 0, top: 0, child: SvgPicture.asset('assets/images/topright.svg')),
          Positioned(
            left: 50,
            top: 150,
            child: SlideTransition(
                position: Tween<Offset>(begin: Offset.zero, end: const Offset(0, 0.5))
                    .animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut)),
                child: SvgPicture.asset('assets/images/horizontallogo.svg')),
          ),
        ],
      ),
    );
  }
}
