import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/repositories/appointment_repository.dart';
import '../datasources/appointment_remote_data_source.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;

  AppointmentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> bookAppointment(String doctorId, String doctorName, DateTime date) async {
    try {
      await remoteDataSource.bookAppointment(doctorId, doctorName, date);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment(String appointmentId) async {
    try {
      await remoteDataSource.cancelAppointment(appointmentId);
      return const Right(null);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getUpcomingAppointments() async {
    try {
      final appointments = await remoteDataSource.getUpcomingAppointments();
      return Right(appointments);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
