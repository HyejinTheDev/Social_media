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
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(
            child: BlocBuilder<ExploreBloc, ExploreState>(
              builder: (context, state) {
                if (state.status == ExploreStatus.initial) {
                  return _buildDefaultContent();
                }
                if (state.status == ExploreStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                if (state.status == ExploreStatus.error) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Đã xảy ra lỗi',
                      style: const TextStyle(color: AppColors.textFog),
                    ),
                  );
                }
                // Loaded
                if (state.users.isEmpty && state.communities.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, color: AppColors.textFog, size: 48),
                        const SizedBox(height: 12),
                        Text(
                          'Không tìm thấy kết quả cho "${state.query}"',
                          style: const TextStyle(color: AppColors.textFog, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }
                return _buildSearchResults(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Default content when no search is active
  Widget _buildDefaultContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Suggestions header
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text(
              'Gợi ý cho bạn',
              style: TextStyle(
                color: AppColors.textSilver,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // Featured card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
                ),
                border: Border.all(color: AppColors.borderTwilight.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.code, color: Colors.lightBlueAccent, size: 26),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flutter Developers',
                              style: TextStyle(color: AppColors.textSilver, fontSize: 18, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Cộng đồng Flutter lớn nhất trên Vibenex',
                              style: TextStyle(color: AppColors.textFog, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text('12.4K thành viên', style: TextStyle(color: AppColors.textSilver, fontSize: 12)),
                      const SizedBox(width: 16),
                      Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.statusEmerald, shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      const Text('892 online', style: TextStyle(color: AppColors.textFog, fontSize: 12)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
                        child: const Text('Tham gia', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Popular section
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
            child: Text('Cộng đồng phổ biến', style: TextStyle(color: AppColors.textSilver, fontSize: 16, fontWeight: FontWeight.w700)),
          ),
          _buildStaticTile(Icons.integration_instructions, 'React Native', '5.2K thành viên'),
          _buildStaticTile(Icons.memory, 'AI & ML', '18.9K thành viên'),
          _buildStaticTile(Icons.cloud_queue, 'DevOps', '3.4K thành viên'),
        ],
      ),
    );
  }

  Widget _buildStaticTile(IconData icon, String title, String members) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: AppColors.surfaceContainerHighest, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: AppColors.textSilver, fontSize: 15, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(members, style: TextStyle(color: AppColors.onSurfaceVariant.withValues(alpha: 0.8), fontSize: 12)),
                ],
              ),
            ),
            Text('Tham gia', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  /// Search results showing both users and communities
  Widget _buildSearchResults(ExploreState state) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        // Users section
        if (state.users.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              children: [
                const Icon(Icons.people_outline, color: AppColors.textFog, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Người dùng (${state.users.length})',
                  style: const TextStyle(color: AppColors.textFog, fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ...state.users.map((user) => _buildUserTile(user)),
        ],

        // Communities section
        if (state.communities.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                const Icon(Icons.groups_outlined, color: AppColors.textFog, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Cộng đồng (${state.communities.length})',
                  style: const TextStyle(color: AppColors.textFog, fontSize: 13, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ...state.communities.map((community) => _buildCommunityTile(community)),
        ],
      ],
    );
  }

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
      trailing: Container(
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
      onTap: () {},
    );
  }
}
