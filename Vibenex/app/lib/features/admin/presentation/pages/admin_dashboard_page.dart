import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/admin_api_service.dart';
import '../../../../core/di/injection.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  late final AdminApiService _api;
  Map<String, dynamic>? _stats;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _api = getIt<AdminApiService>();
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final stats = await _api.getStats();
      setState(() {
        _stats = stats;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = 'Không thể tải dữ liệu. Kiểm tra kết nối backend.';
      });
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
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off, color: AppColors.textFog, size: 48),
                      const SizedBox(height: 12),
                      Text(_error!, style: const TextStyle(color: AppColors.textFog)),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _loadStats,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Thử lại'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.brandViolet),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadStats,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // ── Stats Cards ──
                      _buildStatsGrid(),
                      const SizedBox(height: 24),

                      // ── Charts ──
                      _buildChartSection(
                        title: '📈 Người dùng mới (7 ngày)',
                        chart: _buildLineChart(),
                        color: Colors.tealAccent,
                      ),
                      const SizedBox(height: 16),
                      _buildChartSection(
                        title: '📊 Bài viết mới (7 ngày)',
                        chart: _buildBarChart(),
                        color: Colors.greenAccent,
                      ),
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

  // ═══════════════════════════════════════════
  // ── Stats Grid
  // ═══════════════════════════════════════════
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
        childAspectRatio: 1.35,
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

  // ═══════════════════════════════════════════
  // ── Chart Section Container
  // ═══════════════════════════════════════════
  Widget _buildChartSection({
    required String title,
    required Widget chart,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textSilver, fontSize: 15, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          SizedBox(height: 180, child: chart),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════
  // ── Line Chart — Daily New Users
  // ═══════════════════════════════════════════
  List<_ChartPoint> _parseDailyData(String key) {
    final rawList = _stats?[key] as List<dynamic>? ?? [];
    final points = <_ChartPoint>[];

    // Generate last 7 days as base
    final now = DateTime.now();
    final dayMap = <String, int>{};
    for (int i = 6; i >= 0; i--) {
      final d = now.subtract(Duration(days: i));
      dayMap[DateFormat('yyyy-MM-dd').format(d)] = 0;
    }

    // Fill in actual data
    for (final item in rawList) {
      final dateStr = item['date']?.toString().substring(0, 10) ?? '';
      final count = (item['count'] is int) ? item['count'] as int : int.tryParse(item['count'].toString()) ?? 0;
      if (dayMap.containsKey(dateStr)) {
        dayMap[dateStr] = count;
      }
    }

    int idx = 0;
    dayMap.forEach((date, count) {
      final d = DateTime.parse(date);
      points.add(_ChartPoint(idx.toDouble(), count.toDouble(), DateFormat('dd/MM').format(d)));
      idx++;
    });

    return points;
  }

  Widget _buildLineChart() {
    final points = _parseDailyData('dailyUsers');
    if (points.isEmpty) {
      return const Center(child: Text('Chưa có dữ liệu', style: TextStyle(color: AppColors.textFog)));
    }

    final maxY = points.map((p) => p.y).fold<double>(0, (a, b) => a > b ? a : b);
    final topY = (maxY < 1) ? 5.0 : (maxY * 1.5).ceilToDouble();

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: topY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: (topY / 4).clamp(1, double.infinity),
          getDrawingHorizontalLine: (_) => FlLine(
            color: AppColors.textFog.withValues(alpha: 0.1),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= points.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(points[idx].label, style: const TextStyle(color: AppColors.textFog, fontSize: 10)),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: (topY / 4).clamp(1, double.infinity),
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString(), style: const TextStyle(color: AppColors.textFog, fontSize: 10));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: points.map((p) => FlSpot(p.x, p.y)).toList(),
            isCurved: true,
            curveSmoothness: 0.3,
            color: Colors.tealAccent,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                radius: 4,
                color: Colors.tealAccent,
                strokeWidth: 2,
                strokeColor: AppColors.backgroundDeep,
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.tealAccent.withValues(alpha: 0.3),
                  Colors.tealAccent.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (_) => AppColors.surfaceMidnight,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final idx = spot.x.toInt();
                final label = (idx >= 0 && idx < points.length) ? points[idx].label : '';
                return LineTooltipItem(
                  '$label\n${spot.y.toInt()} người dùng',
                  const TextStyle(color: Colors.tealAccent, fontSize: 12, fontWeight: FontWeight.w600),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════
  // ── Bar Chart — Daily Posts
  // ═══════════════════════════════════════════
  Widget _buildBarChart() {
    final points = _parseDailyData('dailyPosts');
    if (points.isEmpty) {
      return const Center(child: Text('Chưa có dữ liệu', style: TextStyle(color: AppColors.textFog)));
    }

    final maxY = points.map((p) => p.y).fold<double>(0, (a, b) => a > b ? a : b);
    final topY = (maxY < 1) ? 5.0 : (maxY * 1.5).ceilToDouble();

    return BarChart(
      BarChartData(
        maxY: topY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: (topY / 4).clamp(1, double.infinity),
          getDrawingHorizontalLine: (_) => FlLine(
            color: AppColors.textFog.withValues(alpha: 0.1),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final idx = value.toInt();
                if (idx < 0 || idx >= points.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(points[idx].label, style: const TextStyle(color: AppColors.textFog, fontSize: 10)),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: (topY / 4).clamp(1, double.infinity),
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString(), style: const TextStyle(color: AppColors.textFog, fontSize: 10));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: points.map((p) {
          return BarChartGroupData(
            x: p.x.toInt(),
            barRods: [
              BarChartRodData(
                toY: p.y,
                width: 18,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xFF2ECC71), Color(0xFF69F0AE)],
                ),
              ),
            ],
          );
        }).toList(),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => AppColors.surfaceMidnight,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final idx = group.x;
              final label = (idx >= 0 && idx < points.length) ? points[idx].label : '';
              return BarTooltipItem(
                '$label\n${rod.toY.toInt()} bài viết',
                const TextStyle(color: Colors.greenAccent, fontSize: 12, fontWeight: FontWeight.w600),
              );
            },
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════
  // ── Management Menu Item
  // ═══════════════════════════════════════════
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

class _ChartPoint {
  final double x;
  final double y;
  final String label;
  _ChartPoint(this.x, this.y, this.label);
}
