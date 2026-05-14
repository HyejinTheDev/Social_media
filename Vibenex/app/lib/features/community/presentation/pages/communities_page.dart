import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../bloc/community_bloc.dart';
import '../widgets/space_category_icon.dart';
import '../widgets/room_card.dart';

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
            // ─── App Bar ───
            const SliverAppBar(
              title: Text('Cộng đồng', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.bold)),
              backgroundColor: AppColors.backgroundDeep,
              floating: true,
              elevation: 0,
            ),
            
            // ─── Search Bar ───
            SliverToBoxAdapter(child: _buildSearchBar()),

            // ─── Your Spaces ───
            SliverToBoxAdapter(child: _buildSectionHeader('Cộng đồng của bạn', showSeeAll: true)),
            SliverToBoxAdapter(child: _buildYourSpaces()),



            // ─── Voice & Chat Rooms ───
            SliverToBoxAdapter(child: _buildSectionHeader('Phòng Voice & Chat')),
            SliverToBoxAdapter(child: _buildRooms()),

            // Bottom padding for nav bar
            const SliverToBoxAdapter(child: SizedBox(height: 90)),
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
                'Khám phá cộng đồng, chủ đề...',
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
                'Xem tất cả',
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
      const _CategoryData(Icons.palette_outlined, 'Thiết kế', AppGradients.categoryDesign),
      const _CategoryData(Icons.code, 'Lập trình', AppGradients.categoryDev),
      const _CategoryData(Icons.sports_esports_outlined, 'Chơi game', AppGradients.categoryGaming),
      const _CategoryData(Icons.camera_alt_outlined, 'Nhiếp ảnh', AppGradients.categoryPhoto),
      const _CategoryData(Icons.music_note_outlined, 'Âm nhạc', AppGradients.categoryMusic),
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



  // ─────────────────── ROOMS (DISCORD STYLE) ───────────────────

  Widget _buildRooms() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          RoomCard(
            roomName: 'Flutter Vietnam Chill ☕️',
            participantCount: 42,
            speakerAvatars: const [
              'https://i.pravatar.cc/150?u=1',
              'https://i.pravatar.cc/150?u=2',
              'https://i.pravatar.cc/150?u=3',
            ],
            isVoiceRoom: true,
            onTap: () {
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Tính năng Voice Room đang được phát triển')),
               );
            },
          ),
          const SizedBox(height: 12),
          RoomCard(
            roomName: 'Review UI/UX tháng 5',
            participantCount: 15,
            speakerAvatars: const [
              'https://i.pravatar.cc/150?u=4',
              'https://i.pravatar.cc/150?u=5',
            ],
            isVoiceRoom: false,
            onTap: () {
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text('Tính năng Chat Room đang được phát triển')),
               );
            },
          ),
        ],
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
