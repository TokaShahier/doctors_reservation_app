import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/error/failures.dart';
import '../../../appointments/data/models/appointment_model.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile({required String name, String? avatarUrl});
  Future<List<AppointmentModel>> getBookingHistory();
  Future<String> uploadAvatar({
    required Uint8List bytes,
    required String fileName,
  });
  Future<void> deleteAvatar({required String storagePath});
  Future<ProfileModel> updateAvatarUrl(String? avatarUrl);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final supabase.SupabaseClient supabaseClient;

  ProfileRemoteDataSourceImpl(this.supabaseClient);

  supabase.User get _currentUser {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw const ServerFailure('User not authenticated');
    return user;
  }

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', _currentUser.id)
          .single();

      return ProfileModel.fromJson(response);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<ProfileModel> updateProfile({
    required String name,
    String? avatarUrl,
  }) async {
    try {
      await supabaseClient
          .from('profiles')
          .update({
            'name': name,
            'avatar_url': avatarUrl,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', _currentUser.id);

      return await getProfile();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<AppointmentModel>> getBookingHistory() async {
    try {
      final response = await supabaseClient
          .from('appointments')
          .select()
          .eq('patient_id', _currentUser.id)
          .order('appointment_date', ascending: false);
      return (response as List)
          .map((e) => AppointmentModel.fromJson(e))
          .toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<String> uploadAvatar({
    required Uint8List bytes,
    required String fileName,
  }) async {
    try {
      final String extension = fileName.split('.').last.toLowerCase();
      final String mimeExtension =
          ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(extension)
          ? extension
          : 'jpg';
      final String contentType = 'image/$mimeExtension';

      final String path =
          '${_currentUser.id}/${DateTime.now().millisecondsSinceEpoch}.$mimeExtension';

      await supabaseClient.storage
          .from('profile-images')
          .uploadBinary(
            path,
            bytes,
            fileOptions: supabase.FileOptions(
              contentType: contentType,
              upsert: true,
            ),
          );

      final String publicUrl = supabaseClient.storage
          .from('profile-images')
          .getPublicUrl(path);
      return publicUrl;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> deleteAvatar({required String storagePath}) async {
    try {
      await supabaseClient.storage.from('profile-images').remove([storagePath]);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<ProfileModel> updateAvatarUrl(String? avatarUrl) async {
    try {
      await supabaseClient
          .from('profiles')
          .update({
            'avatar_url': avatarUrl,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', _currentUser.id);

      return await getProfile();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
