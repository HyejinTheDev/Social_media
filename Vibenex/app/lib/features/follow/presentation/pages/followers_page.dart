import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../../follow/bloc/follow_bloc.dart';

class FollowersPage extends StatefulWidget {
  final String userId;
  final int initialTab; // 0 = followers, 1 = following

  const FollowersPage({
    super.key,
    required this.userId,
    this.initialTab = 0,
  });

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
    _tabController.addListener(_onTabChanged);
    _loadData(widget.initialTab);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) {
      _loadData(_tabController.index);
    }
  }

  void _loadData(int tabIndex) {
    if (tabIndex == 0) {
      context.read<FollowBloc>().add(FollowLoadFollowersRequested(userId: widget.userId));
    } else {
      context.read<FollowBloc>().add(FollowLoadFollowingRequested(userId: widget.userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kết nối'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Người theo dõi'),
            Tab(text: 'Đang theo dõi'),
          ],
          indicatorColor: cs.primary,
          labelColor: cs.primary,
          unselectedLabelColor: cs.onSurfaceVariant,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUserList(),
          _buildUserList(),
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return BlocBuilder<FollowBloc, FollowState>(
      builder: (context, state) {
        if (state.listStatus == FollowListStatus.loading && state.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.listStatus == FollowListStatus.error) {
          return Center(child: Text(state.errorMessage ?? 'Đã có lỗi xảy ra'));
        }

        if (state.users.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_outline, size: 64, color: Theme.of(context).colorScheme.outlineVariant),
                const SizedBox(height: 16),
                Text(
                  'Chưa có ai',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            final user = state.users[index];
            final avatarUrl = user.avatar != null ? '${AppConstants.baseUrl}${user.avatar}' : null;
            final isFollowing = state.followStatusMap[user.id] ?? false;

            return ListTile(
              leading: AvatarWidget(imageUrl: avatarUrl, radius: 24),
              title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('@${user.username}'),
              trailing: _FollowButton(
                isFollowing: isFollowing,
                onPressed: () => context.read<FollowBloc>().add(FollowToggleRequested(user.id)),
              ),
            );
          },
        );
      },
    );
  }
}

class _FollowButton extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback onPressed;

  const _FollowButton({required this.isFollowing, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (isFollowing) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(100, 36),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          side: BorderSide(color: cs.outline),
        ),
        child: const Text('Đang theo dõi', style: TextStyle(fontSize: 13)),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(100, 36),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text('Theo dõi', style: TextStyle(fontSize: 13)),
    );
  }
}
