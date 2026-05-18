import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../data/admin_api_service.dart';
import '../../../../core/di/injection.dart';
import 'package:dio/dio.dart';

class AdminPostsPage extends StatefulWidget {
  const AdminPostsPage({super.key});

  @override
  State<AdminPostsPage> createState() => _AdminPostsPageState();
}

class _AdminPostsPageState extends State<AdminPostsPage> {
  late final AdminApiService _api;
  List<dynamic> _posts = [];
  int _page = 1;
  int _totalPages = 1;
  bool _loading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _api = AdminApiService(getIt<Dio>());
    _loadPosts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPosts() async {
    setState(() => _loading = true);
    try {
      final data = await _api.getPosts(_page, search: _searchController.text);
      setState(() {
        _posts = data['posts'] ?? [];
        _totalPages = data['totalPages'] ?? 1;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _deletePost(String postId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceMidnight,
        title: const Text('Xác nhận xóa', style: TextStyle(color: AppColors.textSilver)),
        content: const Text('Bạn có chắc muốn xóa bài viết này?', style: TextStyle(color: AppColors.textFog)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Hủy')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Xóa', style: TextStyle(color: Colors.redAccent))),
        ],
      ),
    );

    if (confirm == true) {
      await _api.deletePost(postId);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã xóa bài viết')));
      _loadPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDeep,
        iconTheme: const IconThemeData(color: AppColors.textSilver),
        title: const Text('Quản lý Bài viết', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: AppColors.textSilver, fontSize: 14),
              onSubmitted: (_) { _page = 1; _loadPosts(); },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm nội dung bài viết...',
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
                : _posts.isEmpty
                    ? const Center(child: Text('Không có bài viết', style: TextStyle(color: AppColors.textFog)))
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80),
                        itemCount: _posts.length,
                        itemBuilder: (context, index) => _buildPostTile(_posts[index]),
                      ),
          ),

          if (_totalPages > 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: const Icon(Icons.chevron_left, color: AppColors.textSilver), onPressed: _page > 1 ? () { _page--; _loadPosts(); } : null),
                  Text('$_page / $_totalPages', style: const TextStyle(color: AppColors.textSilver)),
                  IconButton(icon: const Icon(Icons.chevron_right, color: AppColors.textSilver), onPressed: _page < _totalPages ? () { _page++; _loadPosts(); } : null),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPostTile(Map<String, dynamic> post) {
    final author = post['author'] ?? {};
    final content = post['content'] ?? '';
    final images = (post['imageUrls'] as List?)?.length ?? 0;
    final createdAt = DateTime.tryParse(post['createdAt'] ?? '') ?? DateTime.now();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author row
          Row(
            children: [
              AvatarWidget(imageUrl: author['avatar'], radius: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(author['name'] ?? '', style: const TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w600, fontSize: 14)),
                    Text(timeago.format(createdAt, locale: 'vi'), style: const TextStyle(color: AppColors.textFog, fontSize: 11)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                onPressed: () => _deletePost(post['id']),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Content
          Text(
            content.length > 150 ? '${content.substring(0, 150)}...' : content,
            style: const TextStyle(color: AppColors.textSilver, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 8),
          // Stats
          Row(
            children: [
              _stat(Icons.favorite, '${post['likeCount'] ?? 0}'),
              const SizedBox(width: 16),
              _stat(Icons.chat_bubble_outline, '${post['commentCount'] ?? 0}'),
              if (images > 0) ...[const SizedBox(width: 16), _stat(Icons.image, '$images ảnh')],
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textFog),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: AppColors.textFog, fontSize: 11)),
      ],
    );
  }
}
