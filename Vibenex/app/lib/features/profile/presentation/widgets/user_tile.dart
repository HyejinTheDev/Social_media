import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/avatar_widget.dart';

class UserTile extends StatelessWidget {
  final String name;
  final String username;
  final String? avatar;
  final bool isVerified;
  final Widget? trailing;
  final VoidCallback? onTap;

  const UserTile({
    super.key,
    required this.name,
    required this.username,
    this.avatar,
    this.isVerified = false,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: AvatarWidget(imageUrl: avatar != null ? '${AppConstants.baseUrl}$avatar' : null, radius: 24),
      title: Row(children: [
        Flexible(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis)),
        if (isVerified) ...[const SizedBox(width: 4), Icon(Icons.verified, size: 16, color: cs.primary)],
      ]),
      subtitle: Text('@$username', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
      trailing: trailing,
    );
  }
}
