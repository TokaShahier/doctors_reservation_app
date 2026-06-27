import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failures.dart';
import '../models/appointment_model.dart';

abstract class AppointmentRemoteDataSource {
  Future<void> bookAppointment(
    String doctorId,
    String doctorName,
    DateTime date,
  );
  Future<void> cancelAppointment(String appointmentId);
  Future<List<AppointmentModel>> getUpcomingAppointments();
}

class AppointmentRemoteDataSourceImpl implements AppointmentRemoteDataSource {
  final SupabaseClient supabaseClient;

  AppointmentRemoteDataSourceImpl(this.supabaseClient);

  String get _currentUserId {
    final user = supabaseClient.auth.currentUser;
    if (user == null) throw const ServerFailure('User not authenticated');
    return user.id;
  }

  @override
  Future<void> bookAppointment(
    String doctorId,
    String doctorName,
    DateTime date,
  ) async {
    try {
      await supabaseClient.from('appointments').insert({
        'doctor_id': doctorId,
        'doctor_name': doctorName,
        'patient_id': _currentUserId,
        'appointment_date': date.toIso8601String(),
        'status': 'upcoming',
      });
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> cancelAppointment(String appointmentId) async {
    try {
      await supabaseClient
          .from('appointments')
          .update({'status': 'cancelled'})
          .eq('id', appointmentId)
          .eq('patient_id', _currentUserId);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<AppointmentModel>> getUpcomingAppointments() async {
    try {
      final response = await supabaseClient
          .from('appointments')
          .select()
          .eq('patient_id', _currentUserId)
          .eq('status', 'upcoming')
          .order('appointment_date', ascending: true);
      return (response as List)
          .map((e) => AppointmentModel.fromJson(e))
          .toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
