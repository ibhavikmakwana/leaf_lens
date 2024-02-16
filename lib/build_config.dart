class BuildConfig {
  static String get apiKey => _getAPIKey();
  static String _getAPIKey() => const String.fromEnvironment('API_KEY');
}
