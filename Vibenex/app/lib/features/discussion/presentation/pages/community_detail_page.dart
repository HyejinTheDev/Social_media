import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('...'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(child: CircularProgressIndicator(color: cs.primary)),
      );
    }

    if (_error != null || _community == null) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 12),
              Text(_error ?? 'Không tìm thấy Community', style: const TextStyle(color: Colors.white70)),
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // ─── Header ───
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(community.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (community.banner != null)
                    Image.network(community.banner!, fit: BoxFit.cover)
                  else
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [cs.primary.withValues(alpha: 0.6), cs.secondary.withValues(alpha: 0.4)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
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
                    Text(community.description!, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.people_outline, size: 16, color: cs.primary),
                      const SizedBox(width: 4),
                      Text('${community.memberCount} members', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                ],
              ),
            ),
          ),

          // ─── Channels Header ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  Icon(Icons.tag, size: 18, color: cs.primary),
                  const SizedBox(width: 8),
                  Text(
                    'CHANNELS',
                    style: TextStyle(
                      color: cs.onSurfaceVariant,
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
                child: Center(child: Text('Chưa có channel nào.', style: TextStyle(color: Colors.grey))),
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
                      context.push(
                        '/communities/${widget.communityId}/channels/${channel.id}',
                        extra: {'channelName': channel.name, 'communityName': community.name},
                      );
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
      default:
        return Icons.tag;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      leading: Icon(_icon(channel.type), color: cs.primary, size: 22),
      title: Text(channel.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      subtitle: channel.description != null
          ? Text(channel.description!, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12))
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.white38),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }
}
