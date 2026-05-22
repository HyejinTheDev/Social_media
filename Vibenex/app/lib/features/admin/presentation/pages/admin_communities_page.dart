import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/theme/app_colors.dart';
import '../../data/admin_api_service.dart';
import '../../../../core/di/injection.dart';

class AdminCommunitiesPage extends StatefulWidget {
  const AdminCommunitiesPage({super.key});

  @override
  State<AdminCommunitiesPage> createState() => _AdminCommunitiesPageState();
}

class _AdminCommunitiesPageState extends State<AdminCommunitiesPage> {
  late final AdminApiService _api;
  List<dynamic> _communities = [];
  int _page = 1;
  int _totalPages = 1;
  bool _loading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _api = getIt<AdminApiService>();
    _loadCommunities();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCommunities() async {
    setState(() => _loading = true);
    try {
      final data = await _api.getCommunities(_page, search: _searchController.text);
      setState(() {
        _communities = data['communities'] ?? [];
        _totalPages = data['totalPages'] ?? 1;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _deleteCommunity(String id, String name) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceMidnight,
        title: const Text('Xác nhận xóa', style: TextStyle(color: AppColors.textSilver)),
        content: Text('Bạn có chắc muốn xóa phòng "$name"?', style: const TextStyle(color: AppColors.textFog)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Hủy')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Xóa', style: TextStyle(color: Colors.redAccent))),
        ],
      ),
    );
    if (confirm == true) {
      await _api.deleteCommunity(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đã xóa phòng $name')));
      _loadCommunities();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDeep,
        iconTheme: const IconThemeData(color: AppColors.textSilver),
        title: const Text('Quản lý Phòng', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: AppColors.textSilver, fontSize: 14),
              onSubmitted: (_) { _page = 1; _loadCommunities(); },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm phòng...',
                hintStyle: const TextStyle(color: AppColors.textFog, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: AppColors.textFog),
                filled: true,
                fillColor: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator(color: AppColors.brandViolet))
                : _communities.isEmpty
                    ? const Center(child: Text('Không tìm thấy phòng', style: TextStyle(color: AppColors.textFog)))
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: _communities.length,
                        itemBuilder: (context, index) => _buildCommunityTile(_communities[index]),
                      ),
          ),
          if (_totalPages > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: const Icon(Icons.chevron_left, color: AppColors.textSilver), onPressed: _page > 1 ? () { _page--; _loadCommunities(); } : null),
                  Text('$_page / $_totalPages', style: const TextStyle(color: AppColors.textSilver)),
                  IconButton(icon: const Icon(Icons.chevron_right, color: AppColors.textSilver), onPressed: _page < _totalPages ? () { _page++; _loadCommunities(); } : null),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCommunityTile(Map<String, dynamic> community) {
    final memberCount = community['_count']?['members'] ?? community['memberCount'] ?? 0;
    final channelCount = community['_count']?['channels'] ?? 0;
    final createdAt = DateTime.tryParse(community['createdAt'] ?? '') ?? DateTime.now();
    final isPublic = community['isPublic'] == true;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.orangeAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.groups, color: Colors.orangeAccent, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(community['name'] ?? '', style: const TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w700, fontSize: 15), overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 6),
                    Icon(isPublic ? Icons.public : Icons.lock, size: 14, color: AppColors.textFog),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$memberCount thành viên · $channelCount kênh · ${timeago.format(createdAt, locale: 'vi')}',
                  style: const TextStyle(color: AppColors.textFog, fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
            onPressed: () => _deleteCommunity(community['id'], community['name'] ?? ''),
          ),
        ],
      ),
    );
  }
}
