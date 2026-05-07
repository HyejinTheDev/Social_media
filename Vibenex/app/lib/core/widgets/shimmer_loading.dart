import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final bool isCircle;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius = 8,
    this.isCircle = false,
  });

  /// Creates a shimmer placeholder for a post card
  static Widget postCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: avatar + name
          Row(
            children: [
              const ShimmerLoading(width: 40, height: 40, isCircle: true),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ShimmerLoading(width: 120, height: 14),
                  SizedBox(height: 6),
                  ShimmerLoading(width: 80, height: 10),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Content lines
          const ShimmerLoading(height: 14),
          const SizedBox(height: 8),
          const ShimmerLoading(width: 250, height: 14),
          const SizedBox(height: 12),
          // Image placeholder
          const ShimmerLoading(height: 200, borderRadius: 12),
          const SizedBox(height: 12),
          // Action bar
          Row(
            children: const [
              ShimmerLoading(width: 60, height: 14),
              SizedBox(width: 24),
              ShimmerLoading(width: 60, height: 14),
              SizedBox(width: 24),
              ShimmerLoading(width: 60, height: 14),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(),
        ],
      ),
    );
  }

  /// Creates a shimmer placeholder for a user tile
  static Widget userTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const ShimmerLoading(width: 48, height: 48, isCircle: true),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerLoading(width: 140, height: 14),
                SizedBox(height: 6),
                ShimmerLoading(width: 100, height: 12),
              ],
            ),
          ),
          const ShimmerLoading(width: 80, height: 32, borderRadius: 16),
        ],
      ),
    );
  }

  /// Creates a list of shimmer items
  static Widget list({int count = 5, required Widget Function() itemBuilder}) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (_, __) => itemBuilder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? const Color(0xFF2A2A2A) : Colors.grey.shade300,
      highlightColor: isDark ? const Color(0xFF3A3A3A) : Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
