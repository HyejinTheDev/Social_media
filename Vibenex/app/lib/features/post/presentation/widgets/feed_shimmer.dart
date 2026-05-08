import 'package:flutter/material.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class FeedShimmer extends StatelessWidget {
  const FeedShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const ShimmerLoading(width: 40, height: 40, borderRadius: 20),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerLoading(width: 120, height: 16, borderRadius: 4),
                        SizedBox(height: 6),
                        ShimmerLoading(width: 80, height: 12, borderRadius: 4),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const ShimmerLoading(width: double.infinity, height: 14, borderRadius: 4),
                const SizedBox(height: 6),
                const ShimmerLoading(width: 250, height: 14, borderRadius: 4),
                const SizedBox(height: 16),
                const ShimmerLoading(width: double.infinity, height: 200, borderRadius: 12),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    ShimmerLoading(width: 60, height: 24, borderRadius: 12),
                    SizedBox(width: 16),
                    ShimmerLoading(width: 60, height: 24, borderRadius: 12),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
