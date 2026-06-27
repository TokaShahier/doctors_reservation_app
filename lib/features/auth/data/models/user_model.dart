import '../../domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.name,
  });

  factory UserModel.fromSupabaseUser(supabase.User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      name: user.userMetadata?['name'] as String?,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
}
