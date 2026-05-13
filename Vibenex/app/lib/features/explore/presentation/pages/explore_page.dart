import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/mock_data.dart';
import '../widgets/explore_category_chip.dart';
import '../widgets/staff_pick_hero_card.dart';
import '../widgets/popular_community_tile.dart';
import '../widgets/recently_created_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header: Explore Spaces
            _buildAppBar(),

            // Search Bar
            SliverToBoxAdapter(child: _buildSearchBar()),

            // Category Chips
            SliverToBoxAdapter(child: _buildCategoryChips()),

            // Staff Pick Hero Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: StaffPickHeroCard(
                  title: AppMockData.staffPickCommunity['title'] as String,
                  description: AppMockData.staffPickCommunity['description'] as String,
                  badgeText: AppMockData.staffPickCommunity['badgeText'] as String,
                  memberCount: AppMockData.staffPickCommunity['membersCount'] as String,
                  onlineCount: AppMockData.staffPickCommunity['onlineCount'] as String,
                  icon: AppMockData.staffPickCommunity['icon'] as IconData,
                  onTap: () {},
                ),
              ),
            ),

            // Popular in Tech Header
            SliverToBoxAdapter(child: _buildSectionHeader('Popular in Tech', showViewAll: true)),
            
            // Popular List
            SliverToBoxAdapter(child: _buildPopularList()),

            // Recently Created Header
            SliverToBoxAdapter(child: _buildSectionHeader('Recently Created', showViewAll: false)),

            // Recently Created Horizontal List
            SliverToBoxAdapter(child: _buildRecentlyCreatedList()),

            // Bottom padding for nav bar
            const SliverToBoxAdapter(child: SizedBox(height: 90)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Row(
          children: [
            const Icon(Icons.explore_outlined, color: AppColors.textSilver, size: 24),
            const SizedBox(width: 8),
            const Text(
              'Explore Spaces',
              style: TextStyle(
                color: AppColors.textSilver,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.tune, color: AppColors.textFog, size: 24), // Filter/Settings icon
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2), // Added vertical padding instead of fixed height
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
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'Search communities...',
                  hintStyle: TextStyle(color: AppColors.textFog, fontSize: 14),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12), // Let TextField determine its own height with padding
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    const categories = AppMockData.exploreCategories;
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return ExploreCategoryChip(
            label: categories[index],
            isSelected: _selectedCategoryIndex == index,
            onTap: () {
              setState(() => _selectedCategoryIndex = index);
            },
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool showViewAll = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textSilver,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          if (showViewAll)
            GestureDetector(
              onTap: () {},
              child: const Text(
                'VIEW ALL',
                style: TextStyle(
                  color: AppColors.textFog,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPopularList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: AppMockData.popularTechCommunities.map((data) {
          return PopularCommunityTile(
            title: data['title'] as String,
            memberCount: data['members'] as String,
            icon: data['icon'] as IconData,
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecentlyCreatedList() {
    const recentCommunities = AppMockData.recentlyCreatedCommunities;
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: recentCommunities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final data = recentCommunities[index];
          return RecentlyCreatedCard(
            title: data['title'] as String,
            memberCount: data['members'] as String,
            bannerUrl: data['banner'] as String,
            icon: data['icon'] as IconData,
            onTap: () {},
          );
        },
      ),
    );
  }
}
