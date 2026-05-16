import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../community/domain/models/community_models.dart';
import '../../../community/domain/repositories/community_repository.dart';

/// Full-screen page showing a Community's channels (like a Discord server view).
class CommunityDetailPage extends StatefulWidget {
  final String communityId;
  const CommunityDetailPage({super.key, required this.communityId});

  @override
  State<CommunityDetailPage> createState() => _CommunityDetailPageState();
}

class _CommunityDetailPageState extends State<CommunityDetailPage> {
  CommunityModel? _community;
  List<ChannelModel> _channels = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final repo = getIt<CommunityRepository>();
      final community = await repo.getCommunityById(widget.communityId);
      final channels = await repo.getChannels(widget.communityId);
      if (mounted) {
        setState(() {
          _community = community;
          _channels = channels;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (_loading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('...', style: TextStyle(color: AppColors.textSilver)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(child: CircularProgressIndicator(color: cs.primary)),
      );
    }

    if (_error != null || _community == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 12),
              Text(_error ?? 'Không tìm thấy Community', style: const TextStyle(color: AppColors.textFog)),
              TextButton(
                onPressed: () {
                  setState(() { _loading = true; _error = null; });
                  _loadData();
                },
                child: Text('Thử lại', style: TextStyle(color: cs.primary)),
              ),
            ],
          ),
        ),
      );
    }

    final community = _community!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ─── Header ───
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: AppColors.background,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(community.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textSilver)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (community.banner != null)
                    Image.network(community.banner!, fit: BoxFit.cover)
                  else
                    Container(
                      decoration: const BoxDecoration(
                        gradient: AppGradients.primary,
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, AppColors.backgroundDeep.withValues(alpha: 0.9)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Community Info ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (community.description != null && community.description!.isNotEmpty)
                    Text(community.description!, style: const TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.people_outline, size: 16, color: AppColors.textFog),
                      const SizedBox(width: 4),
                      Text('${community.memberCount} members', style: const TextStyle(color: AppColors.textFog, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: AppColors.borderTwilight),
                ],
              ),
            ),
          ),

          // ─── Channels Header ───
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  Icon(Icons.tag, size: 18, color: AppColors.brandViolet),
                  SizedBox(width: 8),
                  Text(
                    'CHANNELS',
                    style: TextStyle(
                      color: AppColors.textFog,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── Channel List ───
          if (_channels.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: Text('Chưa có channel nào.', style: TextStyle(color: AppColors.textFog))),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final channel = _channels[index];
                  return _ChannelTile(
                    channel: channel,
                    onTap: () {
                      if (channel.type == 'LIVE_CHAT') {
                        context.push(
                          '/communities/${widget.communityId}/live-chat/${channel.id}',
                          extra: {'channelName': channel.name, 'communityName': community.name},
                        );
                      } else if (channel.type == 'VOICE') {
                        context.push(
                          '/communities/${widget.communityId}/voice-room/${channel.id}',
                          extra: {'channelName': channel.name, 'communityName': community.name},
                        );
                      } else {
                        context.push(
                          '/communities/${widget.communityId}/channels/${channel.id}',
                          extra: {'channelName': channel.name, 'communityName': community.name},
                        );
                      }
                    },
                  );
                },
                childCount: _channels.length,
              ),
            ),
        ],
      ),
    );
  }
}

class _ChannelTile extends StatelessWidget {
  final ChannelModel channel;
  final VoidCallback onTap;

  const _ChannelTile({required this.channel, required this.onTap});

  IconData _icon(String type) {
    switch (type) {
      case 'ANNOUNCEMENT':
        return Icons.campaign_outlined;
      case 'SHOWCASE':
        return Icons.auto_awesome_outlined;
      case 'LIVE_CHAT':
        return Icons.chat_bubble_outline;
      case 'VOICE':
        return Icons.mic_none;
      default:
        return Icons.tag;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(_icon(channel.type), color: AppColors.primary, size: 22),
      title: Text(channel.name, style: const TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w500)),
      subtitle: channel.description != null
          ? Text(channel.description!, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.textFog, fontSize: 12))
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.outlineVariant),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }
}
