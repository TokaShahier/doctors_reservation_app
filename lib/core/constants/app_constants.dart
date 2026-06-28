class AppConstants {
  // Using String.fromEnvironment is a secure way to handle secrets in Flutter.
  // It reads values passed via --dart-define during build/run time.
  // Example: flutter run --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key

  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue:
        'https://rvhejqywiuqthvwplbkt.supabase.co', // Optional: fallback for dev
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'sb_publishable_ZCMFRYvlDkNK8O4614CVUg_WAQO7fV_', // Optional: fallback for dev
  );

  static const String profileImagesBucket = 'profile-images';
}
