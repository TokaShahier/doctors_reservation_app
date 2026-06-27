import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/appointment_entity.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, void>> bookAppointment(String doctorId, String doctorName, DateTime date);
  Future<Either<Failure, void>> cancelAppointment(String appointmentId);
  Future<Either<Failure, List<AppointmentEntity>>> getUpcomingAppointments();
}
