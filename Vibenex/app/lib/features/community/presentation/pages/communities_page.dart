import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../bloc/community_bloc.dart';
import '../widgets/space_category_icon.dart';
import '../widgets/community_list_card.dart';
import '../widgets/active_discussion_card.dart';

class CommunitiesPage extends StatefulWidget {
  const CommunitiesPage({super.key});

  @override
  State<CommunitiesPage> createState() => _CommunitiesPageState();
}

class _CommunitiesPageState extends State<CommunitiesPage> {
  @override
  void initState() {
    super.initState();
    context.read<CommunityBloc>().add(const LoadCommunitiesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ─── Header ───
            _buildAppBar(),

            // ─── Search Bar ───
            SliverToBoxAdapter(child: _buildSearchBar()),

            // ─── Your Spaces ───
            SliverToBoxAdapter(child: _buildSectionHeader('Your Spaces', showSeeAll: true)),
            SliverToBoxAdapter(child: _buildYourSpaces()),

            // ─── Trending Now ───
            SliverToBoxAdapter(child: _buildSectionHeader('🔥 Trending Now')),
            _buildTrendingNow(),

            // ─── Active Discussions ───
            SliverToBoxAdapter(child: _buildSectionHeader('Active Discussions')),
            SliverToBoxAdapter(child: _buildActiveDiscussions()),

            // Bottom padding for nav bar
            const SliverToBoxAdapter(child: SizedBox(height: 90)),
          ],
        ),
      ),
    );
  }

  // ─────────────────── HEADER ───────────────────

  Widget _buildAppBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Row(
          children: [
            // Vibenex logo
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: AppGradients.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.blur_on, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              'Vibenex',
              style: TextStyle(
                color: AppColors.textSilver,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            const Spacer(),
            // Search icon
            IconButton(
              icon: const Icon(Icons.search, color: AppColors.textFog, size: 24),
              onPressed: () => context.go('/search'),
            ),
            // Notification icon with badge
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined, color: AppColors.textFog, size: 24),
                  onPressed: () => context.push('/notifications'),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.hotPink,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────── SEARCH BAR ───────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: GestureDetector(
        onTap: () => context.go('/search'),
        child: Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.borderTwilight, width: 1),
          ),
          child: const Row(
            children: [
              Icon(Icons.search, color: AppColors.textFog, size: 20),
              SizedBox(width: 10),
              Text(
                'Discover Spaces, topics, people...',
                style: TextStyle(color: AppColors.textFog, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────── SECTION HEADER ───────────────────

  Widget _buildSectionHeader(String title, {bool showSeeAll = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textSilver,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          if (showSeeAll)
            GestureDetector(
              onTap: () {},
              child: const Text(
                'See all',
                style: TextStyle(
                  color: AppColors.brandViolet,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ─────────────────── YOUR SPACES ───────────────────

  Widget _buildYourSpaces() {
    final categories = [
      const _CategoryData(Icons.palette_outlined, 'Design', AppGradients.categoryDesign),
      const _CategoryData(Icons.code, 'Flutter Dev', AppGradients.categoryDev),
      const _CategoryData(Icons.sports_esports_outlined, 'Gaming', AppGradients.categoryGaming),
      const _CategoryData(Icons.camera_alt_outlined, 'Photo', AppGradients.categoryPhoto),
      const _CategoryData(Icons.music_note_outlined, 'Music', AppGradients.categoryMusic),
    ];

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return SpaceCategoryIcon(
            icon: cat.icon,
            label: cat.label,
            gradient: cat.gradient,
            onTap: () {},
          );
        },
      ),
    );
  }

  // ─────────────────── TRENDING NOW ───────────────────

  Widget _buildTrendingNow() {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, state) {
        if (state is CommunityLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(color: AppColors.brandViolet),
              ),
            ),
          );
        }
        if (state is CommunityLoaded) {
          final communities = state.communities;
          if (communities.isEmpty) {
            return const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: Text(
                    'Chưa có cộng đồng nào.',
                    style: TextStyle(color: AppColors.textFog),
                  ),
                ),
              ),
            );
          }
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: CommunityListCard(
                      community: communities[index],
                      onTap: () => context.push('/communities/${communities[index].id}'),
                    ),
                  );
                },
                childCount: communities.length,
              ),
            ),
          );
        }
        if (state is CommunityError) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.error_outline, size: 40, color: AppColors.error),
                    const SizedBox(height: 8),
                    Text(state.message, style: const TextStyle(color: AppColors.textFog)),
                    TextButton(
                      onPressed: () => context.read<CommunityBloc>().add(const LoadCommunitiesRequested()),
                      child: const Text('Thử lại', style: TextStyle(color: AppColors.brandViolet)),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  // ─────────────────── ACTIVE DISCUSSIONS ───────────────────

  Widget _buildActiveDiscussions() {
    // Mock data — giống hình mẫu thiết kế
    final discussions = [
      const ActiveDiscussionCard(
        authorName: 'Alex Rivera',
        badge: 'Flutter dev',
        badgeColor: Color(0xFF60A5FA),
        content: 'How are you handling complex state in large-scale Flutter apps? BLoC vs Riverpod in 2024?',
        replyCount: 142,
        likeCount: 89,
        timeAgo: '2h ago',
      ),
      const ActiveDiscussionCard(
        authorName: 'Sarah Chen',
        badge: 'design',
        badgeColor: Color(0xFFF97316),
        content: 'The transition from Glassmorphism to Bento Grids: Why layout density is winning.',
        replyCount: 58,
        likeCount: 214,
        timeAgo: '5h ago',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: discussions
            .map((card) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: card,
                ))
            .toList(),
      ),
    );
  }
}

// ─── Helper data class ───
class _CategoryData {
  final IconData icon;
  final String label;
  final LinearGradient gradient;
  const _CategoryData(this.icon, this.label, this.gradient);
}
