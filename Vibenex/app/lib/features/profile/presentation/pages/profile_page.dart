import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../../../core/widgets/loading_overlay.dart';
import '../../bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  final String? userId;
  const ProfilePage({super.key, this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileLoadRequested(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (state is ProfileError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }
        final user = state is ProfileLoaded ? state.user : (state is ProfileUpdating ? state.user : null);
        final isOwn = state is ProfileLoaded ? state.isOwnProfile : true;
        if (user == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

        return Scaffold(
          body: LoadingOverlay(
            isLoading: state is ProfileUpdating,
            child: CustomScrollView(slivers: [
              // Cover + Avatar header
              SliverToBoxAdapter(child: _buildHeader(context, cs, user, isOwn)),
              // Stats
              SliverToBoxAdapter(child: _buildStats(context, cs, user)),
              // Bio
              if (user.bio != null && user.bio!.isNotEmpty)
                SliverToBoxAdapter(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(user.bio!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5)),
                )),
              // Action buttons
              SliverToBoxAdapter(child: _buildActions(context, cs, isOwn, state)),
              // Post grid placeholder
              SliverToBoxAdapter(child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  const Divider(),
                  const SizedBox(height: 32),
                  Icon(Icons.grid_on_rounded, size: 48, color: cs.outlineVariant),
                  const SizedBox(height: 12),
                  Text('Chưa có bài viết nào', style: TextStyle(color: cs.onSurfaceVariant)),
                ]),
              )),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ]),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme cs, dynamic user, bool isOwn) {
    final coverUrl = user.coverPhoto != null ? '${AppConstants.baseUrl}${user.coverPhoto}' : null;
    final avatarUrl = user.avatar != null ? '${AppConstants.baseUrl}${user.avatar}' : null;

    return Stack(clipBehavior: Clip.none, children: [
      // Cover photo
      Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [cs.primary.withValues(alpha: 0.7), cs.secondary.withValues(alpha: 0.5)]),
        ),
        child: coverUrl != null
          ? CachedNetworkImage(imageUrl: coverUrl, fit: BoxFit.cover, errorWidget: (_, __, ___) => const SizedBox())
          : null,
      ),
      // Avatar
      Positioned(left: 20, bottom: -44, child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 4)),
        child: AvatarWidget(imageUrl: avatarUrl, radius: 44),
      )),
      // Top bar
      Positioned(top: 0, left: 0, right: 0, child: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(children: [
          if (widget.userId != null)
            IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20), onPressed: () => context.pop()),
          const Spacer(),
          if (isOwn)
            IconButton(icon: const Icon(Icons.settings_outlined, color: Colors.white), onPressed: () {}),
        ]),
      ))),
      // Name + username (right side of avatar)
      Positioned(left: 120, bottom: -36, right: 16, child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Flexible(child: Text(user.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis)),
            if (user.isVerified) ...[const SizedBox(width: 4), Icon(Icons.verified, size: 18, color: cs.primary)],
          ]),
          Text('@${user.username}', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
        ],
      )),
    ]);
  }

  Widget _buildStats(BuildContext context, ColorScheme cs, dynamic user) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 8),
      child: Row(children: [
        _StatItem(count: user.postsCount, label: 'Bài viết'),
        const SizedBox(width: 24),
        _StatItem(count: user.followersCount, label: 'Followers'),
        const SizedBox(width: 24),
        _StatItem(count: user.followingCount, label: 'Following'),
      ]),
    );
  }

  Widget _buildActions(BuildContext context, ColorScheme cs, bool isOwn, ProfileState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: isOwn
        ? OutlinedButton.icon(
            onPressed: () => context.push('/edit-profile'),
            icon: const Icon(Icons.edit_outlined, size: 18),
            label: const Text('Chỉnh sửa hồ sơ'),
            style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 44), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          )
        : Row(children: [
            Expanded(child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(minimumSize: const Size(0, 44), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: Text(state is ProfileLoaded && state.isFollowing ? 'Đang theo dõi' : 'Theo dõi'),
            )),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(minimumSize: const Size(44, 44), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Icon(Icons.chat_bubble_outline, size: 20),
            ),
          ]),
    );
  }
}

class _StatItem extends StatelessWidget {
  final int count;
  final String label;
  const _StatItem({required this.count, required this.label});

  String _format(int n) => n >= 1000 ? '${(n / 1000).toStringAsFixed(1)}K' : n.toString();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(_format(count), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 2),
      Text(label, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
    ]);
  }
}
