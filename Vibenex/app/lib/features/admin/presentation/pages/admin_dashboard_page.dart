import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/admin_api_service.dart';
import '../../../../core/di/injection.dart';
import 'package:dio/dio.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  late final AdminApiService _api;
  Map<String, dynamic>? _stats;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _api = AdminApiService(getIt<Dio>());
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() => _loading = true);
    try {
      final stats = await _api.getStats();
      setState(() {
        _stats = stats;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDeep,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDeep,
        title: const Row(
          children: [
            Icon(Icons.admin_panel_settings, color: AppColors.brandViolet, size: 26),
            SizedBox(width: 10),
            Text('Admin Dashboard', style: TextStyle(color: AppColors.textSilver, fontWeight: FontWeight.w700)),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textSilver),
          onPressed: () => context.pop(),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.brandViolet))
          : RefreshIndicator(
              onRefresh: _loadStats,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // ── Stats Cards ──
                  _buildStatsGrid(),
                  const SizedBox(height: 24),

                  // ── Management Menu ──
                  const Text(
                    'Quản lý',
                    style: TextStyle(color: AppColors.textSilver, fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  _buildMenuItem(
                    icon: Icons.people,
                    title: 'Quản lý Người dùng',
                    subtitle: '${_stats?['totalUsers'] ?? 0} người dùng',
                    color: Colors.blueAccent,
                    onTap: () => context.push('/admin/users'),
                  ),
                  _buildMenuItem(
                    icon: Icons.article,
                    title: 'Quản lý Bài viết',
                    subtitle: '${_stats?['totalPosts'] ?? 0} bài viết',
                    color: Colors.greenAccent,
                    onTap: () => context.push('/admin/posts'),
                  ),
                  _buildMenuItem(
                    icon: Icons.play_circle,
                    title: 'Quản lý Shorts',
                    subtitle: '${_stats?['totalShorts'] ?? 0} video',
                    color: Colors.pinkAccent,
                    onTap: () => context.push('/admin/shorts'),
                  ),
                  _buildMenuItem(
                    icon: Icons.groups,
                    title: 'Quản lý Phòng / Cộng đồng',
                    subtitle: '${_stats?['totalCommunities'] ?? 0} phòng',
                    color: Colors.orangeAccent,
                    onTap: () => context.push('/admin/communities'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatsGrid() {
    final items = [
      _StatItem('Người dùng', _stats?['totalUsers'] ?? 0, Icons.person, Colors.blueAccent),
      _StatItem('Mới (7 ngày)', _stats?['newUsers'] ?? 0, Icons.person_add, Colors.tealAccent),
      _StatItem('Bài viết', _stats?['totalPosts'] ?? 0, Icons.article, Colors.greenAccent),
      _StatItem('Shorts', _stats?['totalShorts'] ?? 0, Icons.play_circle, Colors.pinkAccent),
      _StatItem('Phòng', _stats?['totalCommunities'] ?? 0, Icons.groups, Colors.orangeAccent),
      _StatItem('Tin nhắn', _stats?['totalMessages'] ?? 0, Icons.chat_bubble, Colors.purpleAccent),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                item.color.withValues(alpha: 0.15),
                item.color.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: item.color.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(item.icon, color: item.color, size: 28),
              const Spacer(),
              Text(
                '${item.value}',
                style: TextStyle(
                  color: item.color,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.label,
                style: const TextStyle(color: AppColors.textFog, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(color: AppColors.textSilver, fontSize: 15, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: AppColors.textFog, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.textFog),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem {
  final String label;
  final dynamic value;
  final IconData icon;
  final Color color;
  _StatItem(this.label, this.value, this.icon, this.color);
}
