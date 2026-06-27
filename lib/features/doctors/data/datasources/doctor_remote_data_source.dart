import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failures.dart';
import '../models/doctor_model.dart';

abstract class DoctorRemoteDataSource {
  Future<List<DoctorModel>> getDoctors();
  Future<List<DoctorModel>> searchDoctors(String query);
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  final SupabaseClient supabaseClient;

  DoctorRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<DoctorModel>> getDoctors() async {
    try {
      final response = await supabaseClient.from('doctors').select();
      return (response as List).map((e) => DoctorModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<DoctorModel>> searchDoctors(String query) async {
    try {
      final response = await supabaseClient
          .from('doctors')
          .select()
          .ilike('name', '%$query%');
      return (response as List).map((e) => DoctorModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
