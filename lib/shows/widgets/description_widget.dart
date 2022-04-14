import 'package:flutter/material.dart';
import 'package:tv_shows/shows/util/show.dart';

class DescriptionWidget extends StatefulWidget {
  final Show show;

  const DescriptionWidget({required this.show, Key? key}) : super(key: key);

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.easeOut),
      ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: _controller!, curve: Curves.easeOut),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: widget.show.description != null ? Text(widget.show.description!) : null,
        ),
      ),
    );
  }
}
