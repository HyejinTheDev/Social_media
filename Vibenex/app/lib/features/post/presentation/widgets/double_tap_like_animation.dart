import 'package:flutter/material.dart';

class DoubleTapLikeAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback onDoubleTap;

  const DoubleTapLikeAnimation({
    super.key,
    required this.child,
    required this.onDoubleTap,
  });

  @override
  State<DoubleTapLikeAnimation> createState() => _DoubleTapLikeAnimationState();
}

class _DoubleTapLikeAnimationState extends State<DoubleTapLikeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _showHeart = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    widget.onDoubleTap();
    setState(() {
      _showHeart = true;
    });
    _controller.forward().then((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        _controller.reverse().then((_) {
          if (mounted) {
            setState(() {
              _showHeart = false;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.child,
          if (_showHeart)
            ScaleTransition(
              scale: _scaleAnimation,
              child: const Icon(
                Icons.favorite,
                color: Colors.white,
                size: 100,
                shadows: [Shadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
              ),
            ),
        ],
      ),
    );
  }
}
