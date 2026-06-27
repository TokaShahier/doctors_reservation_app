import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../datasources/doctor_remote_data_source.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DoctorEntity>>> getDoctors() async {
    try {
      final doctors = await remoteDataSource.getDoctors();
      return Right(doctors);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> searchDoctors(String query) async {
    try {
      final doctors = await remoteDataSource.searchDoctors(query);
      return Right(doctors);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
