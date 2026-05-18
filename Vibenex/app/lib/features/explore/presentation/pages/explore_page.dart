import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../bloc/explore_bloc.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Dispatch sự kiện tải gợi ý ban đầu
    context.read<ExploreBloc>().add(const LoadExploreSuggestions());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDeep,
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Icon(Icons.explore_outlined, color: AppColors.textSilver, size: 24),
            SizedBox(width: 8),
            Text(
              'Khám phá',
              style: TextStyle(
                color: AppColors.textSilver,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderTwilight, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.textFog, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: AppColors.textSilver, fontSize: 14),
                      onChanged: (val) {
                        context.read<ExploreBloc>().add(ExploreQueryChanged(val));
                      },
                      onSubmitted: (val) {
                        context.read<ExploreBloc>().add(ExploreSubmitted(val));
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Tìm người dùng, cộng đồng...',
                        hintStyle: const TextStyle(color: AppColors.textFog, fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close, color: AppColors.textFog, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  context.read<ExploreBloc>().add(const ExploreCleared());
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body: Default or Search Results
          // Tabs
          const TabBar(
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textFog,
            tabs: [
              Tab(text: 'Người dùng'),
              Tab(text: 'Phòng / Cộng đồng'),
            ],
          ),

          // Body: TabBarView
          Expanded(
            child: BlocBuilder<ExploreBloc, ExploreState>(
              builder: (context, state) {
                if (state.status == ExploreStatus.loading) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                }
                if (state.status == ExploreStatus.error) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Đã xảy ra lỗi',
                      style: const TextStyle(color: AppColors.textFog),
                    ),
                  );
                }
                // Loaded (either suggestions or search results)
                return TabBarView(
                  children: [
                    _buildUserList(state.users, state.query),
                    _buildCommunityList(state.communities, state.query),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildUserList(List users, String query) {
    if (users.isEmpty) {
      return Center(
        child: Text(
          query.isEmpty ? 'Không có gợi ý người dùng' : 'Không tìm thấy người dùng "$query"',
          style: const TextStyle(color: AppColors.textFog, fontSize: 14),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: users.length,
      itemBuilder: (context, index) => _buildUserTile(users[index]),
    );
  }

  Widget _buildCommunityList(List communities, String query) {
    if (communities.isEmpty) {
      return Center(
        child: Text(
          query.isEmpty ? 'Không có gợi ý phòng' : 'Không tìm thấy phòng "$query"',
          style: const TextStyle(color: AppColors.textFog, fontSize: 14),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: communities.length,
      itemBuilder: (context, index) => _buildCommunityTile(communities[index]),
    );
  }

  /// Default content when no search is active
  // Removed old default content methods

  Widget _buildUserTile(user) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: AvatarWidget(imageUrl: user.avatar, radius: 22),
      title: Row(
        children: [
          Flexible(
            child: Text(
              user.name ?? user.username,
              style: const TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w600, fontSize: 15),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (user.isVerified == true) ...[
            const SizedBox(width: 4),
            const Icon(Icons.verified, color: AppColors.primary, size: 16),
          ],
        ],
      ),
      subtitle: Text(
        '@${user.username}',
        style: const TextStyle(color: AppColors.textFog, fontSize: 13),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Nút Nhắn tin
          GestureDetector(
            onTap: () => context.push('/chat/new/${user.id}', extra: {
              'id': user.id,
              'name': user.name ?? user.username,
              'username': user.username,
              'avatar': user.avatar,
              'isVerified': user.isVerified ?? false,
            }),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chat_bubble_outline, color: AppColors.primary, size: 18),
            ),
          ),
          const SizedBox(width: 8),
          // Nút Xem profile
          GestureDetector(
            onTap: () => context.push('/profile/${user.id}'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Xem',
                style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      onTap: () => context.push('/profile/${user.id}'),
    );
  }

  Widget _buildCommunityTile(community) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.groups, color: AppColors.primary, size: 22),
      ),
      title: Text(
        community.name,
        style: const TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w600, fontSize: 15),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        community.description ?? 'Cộng đồng',
        style: const TextStyle(color: AppColors.textFog, fontSize: 13),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Tham gia',
          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
      onTap: () => context.push('/communities/${community.id}'),
    );
  }
}
