import 'package:flutter/material.dart';

/// Centralized Mock Data for the application UI.
/// This prevents hardcoding text/values directly into the UI components (Clean Code).
class AppMockData {
  AppMockData._();

  // ---------------------------------------------------------
  // EXPLORE SPACES PAGE (search_screen.dart)
  // ---------------------------------------------------------

  static const List<String> exploreCategories = [
    'All',
    'Tech',
    'Design',
    'Gaming',
    'Music'
  ];

  static const Map<String, dynamic> staffPickCommunity = {
    'title': 'Flutter Developers',
    'description': 'The largest Flutter community on Vibenex',
    'badgeText': 'STAFF PICK',
    'membersCount': '12.4K members',
    'onlineCount': '892 online',
    'icon': Icons.remove_red_eye,
  };

  static const List<Map<String, dynamic>> popularTechCommunities = [
    {
      'title': 'React Native',
      'members': '5.2K members',
      'icon': Icons.integration_instructions,
    },
    {
      'title': 'AI & ML',
      'members': '18.9K members',
      'icon': Icons.memory,
    },
    {
      'title': 'DevOps',
      'members': '3.4K members',
      'icon': Icons.cloud_queue,
    },
  ];

  static const List<Map<String, dynamic>> recentlyCreatedCommunities = [
    {
      'title': 'Retro Gaming',
      'members': '142 members',
      'banner': 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=400&auto=format&fit=crop',
      'icon': Icons.videogame_asset,
    },
    {
      'title': 'Digital Canvas',
      'members': '89 members',
      'banner': 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=400&auto=format&fit=crop',
      'icon': Icons.brush,
    },
  ];
}
