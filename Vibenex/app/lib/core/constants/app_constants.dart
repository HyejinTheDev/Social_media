class AppConstants {
  AppConstants._();

  // API
  static const String baseUrl = 'http://192.168.60.234:3001'; // IP thật của máy tính để thiết bị vật lý kết nối
  static const String baseUrlWeb = 'http://localhost:3001';

  // Storage Keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String hasSeenOnboardingKey = 'has_seen_onboarding';
  static const String themeModeKey = 'theme_mode';
  static const String localeKey = 'locale';

  // Pagination
  static const int defaultPageSize = 10;

  // Media
  static const int maxImages = 4;
  static const int maxVideoSeconds = 60;
  static const int maxStoryVideoSeconds = 30;
  static const int maxBioLength = 150;
  static const int maxPostLength = 2000;
  static const int maxCaptionLength = 100;

  // Story
  static const int storyImageDurationSeconds = 5;
  static const int storyExpiryHours = 24;
}
