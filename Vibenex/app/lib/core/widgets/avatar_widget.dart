import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/app_constants.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final VoidCallback? onTap;
  final bool showBorder;
  final Color? borderColor;
  final double borderWidth;
  final bool showEditIcon;
  final String? name;

  const AvatarWidget({
    super.key,
    this.imageUrl,
    this.radius = 24,
    this.onTap,
    this.showBorder = false,
    this.borderColor,
    this.borderWidth = 2,
    this.showEditIcon = false,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    String? finalImageUrl = imageUrl;
    if (finalImageUrl != null && finalImageUrl.isNotEmpty && !finalImageUrl.startsWith('http')) {
      finalImageUrl = '${AppConstants.baseUrl}$finalImageUrl';
    }

    Widget avatar = CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.primaryContainer,
      backgroundImage: finalImageUrl != null && finalImageUrl.isNotEmpty
          ? CachedNetworkImageProvider(finalImageUrl)
          : null,
      child: finalImageUrl == null || finalImageUrl.isEmpty
          ? _buildInitials(context)
          : null,
    );

    if (showBorder) {
      avatar = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? colorScheme.primary,
            width: borderWidth,
          ),
        ),
        padding: EdgeInsets.all(borderWidth),
        child: avatar,
      );
    }

    if (showEditIcon) {
      avatar = Stack(
        children: [
          avatar,
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.surface, width: 2),
              ),
              child: Icon(
                Icons.camera_alt,
                size: radius * 0.35,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      );
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }

  Widget _buildInitials(BuildContext context) {
    final initials = name != null && name!.isNotEmpty
        ? name!.split(' ').take(2).map((w) => w[0].toUpperCase()).join()
        : '?';
    return Text(
      initials,
      style: TextStyle(
        fontSize: radius * 0.7,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
