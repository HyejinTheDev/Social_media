import 'package:flutter/material.dart';

class StoryProgressBar extends StatelessWidget {
  final int count;
  final int currentIndex;
  final AnimationController? animationController;

  const StoryProgressBar({
    super.key,
    required this.count,
    required this.currentIndex,
    this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: List.generate(count, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: SizedBox(
                  height: 2.5,
                  child: _buildSegment(index),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSegment(int index) {
    if (index < currentIndex) {
      // Already watched
      return Container(color: Colors.white);
    } else if (index == currentIndex && animationController != null) {
      // Currently playing
      return AnimatedBuilder(
        animation: animationController!,
        builder: (context, child) {
          return LinearProgressIndicator(
            value: animationController!.value,
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 2.5,
          );
        },
      );
    } else {
      // Not yet watched
      return Container(color: Colors.white.withValues(alpha: 0.3));
    }
  }
}
