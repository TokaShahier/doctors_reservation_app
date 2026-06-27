import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../../../core/error/failures.dart';
import '../../../appointments/data/models/appointment_model.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile(String name);
  Future<List<AppointmentModel>> getBookingHistory();
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
      return ProfileModel.fromSupabaseUser(_currentUser);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<ProfileModel> updateProfile(String name) async {
    try {
      final response = await supabaseClient.auth.updateUser(
        supabase.UserAttributes(data: {'name': name}),
      );
      if (response.user == null) throw const ServerFailure('Update failed');
      return ProfileModel.fromSupabaseUser(response.user!);
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
      return (response as List).map((e) => AppointmentModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
