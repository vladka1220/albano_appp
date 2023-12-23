import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  final String imagePath;
  final double width;
  final double height;
  final Duration duration;

  const AnimatedLogo({
    super.key,
    required this.imagePath,
    this.width = 300,
    this.height = 250,
    this.duration = const Duration(seconds: 3),
  });

  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Image.asset(
        widget.imagePath,
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}
