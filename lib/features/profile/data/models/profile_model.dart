import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory ProfileModel.fromSupabaseUser(supabase.User user) {
    return ProfileModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String? ?? 'Unknown',
    );
  }
}
