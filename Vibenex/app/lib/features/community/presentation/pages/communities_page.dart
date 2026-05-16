import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/community_bloc.dart';
import '../../domain/models/community_models.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await context.push('/create-community');
          if (result == true && mounted) {
            context.read<CommunityBloc>().add(const LoadCommunitiesRequested());
          }
        },
        backgroundColor: AppColors.brandViolet,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Tạo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ─── App Bar ───
            const SliverAppBar(
              title: Text('Phòng Voice & Chat', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.bold)),
              backgroundColor: AppColors.backgroundDeep,
              floating: true,
              elevation: 0,
            ),
            
            // ─── Search Bar ───
            SliverToBoxAdapter(child: _buildSearchBar()),

            // ─── Room List ───
            _buildRoomList(),

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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
                'Khám phá phòng trò chuyện...',
                style: TextStyle(color: AppColors.textFog, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────── ROOM LIST FROM API ───────────────────

  Widget _buildRoomList() {
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

        if (state is CommunityError) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.textFog, size: 48),
                    const SizedBox(height: 8),
                    Text(state.message, style: const TextStyle(color: AppColors.textFog)),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => context.read<CommunityBloc>().add(const LoadCommunitiesRequested()),
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state is CommunityLoaded) {
          if (state.communities.isEmpty) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.mic_none, color: AppColors.textFog.withValues(alpha: 0.5), size: 64),
                      const SizedBox(height: 12),
                      const Text(
                        'Chưa có phòng nào',
                        style: TextStyle(color: AppColors.textFog, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Bấm nút "Tạo" bên dưới để tạo phòng đầu tiên!',
                        style: TextStyle(color: AppColors.textFog, fontSize: 13),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: _buildRoomItem(state.communities[index], index),
              ),
              childCount: state.communities.length,
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  Widget _buildRoomItem(CommunityModel community, int index) {
    // Generate some mock avatars for now
    final mockAvatars = [
      'https://i.pravatar.cc/150?u=${index + 1}',
      'https://i.pravatar.cc/150?u=${index + 2}',
      'https://i.pravatar.cc/150?u=${index + 3}',
    ];
    
    // Use real isVoiceRoom from API
    final isVoiceRoom = community.isVoiceRoom;

    return RoomCard(
      roomName: community.name,
      participantCount: community.memberCount > 0 ? community.memberCount : (index + 1) * 3,
      speakerAvatars: mockAvatars,
      isVoiceRoom: isVoiceRoom,
      onTap: () {
        if (isVoiceRoom) {
          context.push(
            '/communities/${community.id}/voice-room/mock-voice-channel',
            extra: {
              'channelName': community.name,
              'communityName': community.name,
            },
          );
        } else {
          context.push(
            '/communities/${community.id}/live-chat/mock-chat-channel',
            extra: {
              'channelName': community.name,
              'communityName': community.name,
            },
          );
        }
      },
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppColors.textFog, size: 22),
            color: AppColors.surfaceContainerHigh,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onSelected: (value) {
              switch (value) {
                case 'share':
                  _shareViaChatDialog(community);
                  break;
                case 'edit':
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Chức năng sửa đang phát triển')),
                  );
                  break;
                case 'delete':
                  _confirmDeleteCommunity(community);
                  break;
              }
            },
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, color: AppColors.brandViolet, size: 20),
                    SizedBox(width: 12),
                    Text('Chia sẻ phòng', style: TextStyle(color: AppColors.textSilver)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.blueAccent, size: 20),
                    SizedBox(width: 12),
                    Text('Sửa thông tin', style: TextStyle(color: Colors.blueAccent)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                    SizedBox(width: 12),
                    Text('Xóa phòng', style: TextStyle(color: Colors.redAccent)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _shareViaChatDialog(CommunityModel community) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerHigh,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Chia sẻ qua tin nhắn', style: TextStyle(color: AppColors.textSilver)),
          content: const Text(
            'Mở tab Tin nhắn và gửi link phòng tới bạn bè.',
            style: TextStyle(color: AppColors.textFog),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Đóng'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.brandViolet),
              onPressed: () {
                Navigator.pop(ctx);
                context.push('/messages');
              },
              child: const Text('Mở tin nhắn', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteCommunity(CommunityModel community) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerHigh,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Xóa phòng?', style: TextStyle(color: Colors.redAccent)),
          content: Text(
            'Bạn có chắc muốn XÓA VĨNH VIỄN phòng "${community.name}"? Hành động này không thể hoàn tác!',
            style: const TextStyle(color: AppColors.textFog),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                Navigator.pop(ctx);
                context.read<CommunityBloc>().add(DeleteCommunityRequested(
                  communityId: community.id,
                  onResult: (error) {
                    if (error == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đã xóa phòng'), backgroundColor: Colors.green),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error), backgroundColor: Colors.red),
                      );
                    }
                  },
                ));
              },
              child: const Text('Xóa', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
