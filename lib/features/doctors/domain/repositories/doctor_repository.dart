import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/doctor_entity.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<DoctorEntity>>> getDoctors();
  Future<Either<Failure, List<DoctorEntity>>> searchDoctors(String query);
}
