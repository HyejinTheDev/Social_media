import 'package:flutter/material.dart';

/// A shimmer effect widget for loading placeholders
class ShimmerBox extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Color(0xFF2A2A3C),
                Color(0xFF3A3A4C),
                Color(0xFF2A2A3C),
              ],
              stops: [
                (_animation.value - 0.3).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.3).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Shimmer loading for a post card
class PostShimmer extends StatelessWidget {
  const PostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ShimmerBox(width: 42, height: 42, borderRadius: 21),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerBox(width: 120, height: 14),
                  SizedBox(height: 6),
                  ShimmerBox(width: 80, height: 10),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const ShimmerBox(width: double.infinity, height: 14),
          const SizedBox(height: 8),
          const ShimmerBox(width: 200, height: 14),
          const SizedBox(height: 16),
          const ShimmerBox(width: double.infinity, height: 180, borderRadius: 12),
        ],
      ),
    );
  }
}

/// Shimmer loading for story row
class StoryShimmer extends StatelessWidget {
  const StoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, __) => const Padding(
          padding: EdgeInsets.only(right: 12),
          child: Column(
            children: [
              ShimmerBox(width: 64, height: 64, borderRadius: 32),
              SizedBox(height: 8),
              ShimmerBox(width: 50, height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer loading for room cards
class RoomShimmer extends StatelessWidget {
  const RoomShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const ShimmerBox(width: 48, height: 48, borderRadius: 14),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerBox(width: 140, height: 14),
                SizedBox(height: 8),
                ShimmerBox(width: 100, height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Beautiful empty state widget
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF8B5CF6).withValues(alpha: 0.2),
                    const Color(0xFF6366F1).withValues(alpha: 0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: const Color(0xFF8B5CF6)),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B5CF6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(actionLabel!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
