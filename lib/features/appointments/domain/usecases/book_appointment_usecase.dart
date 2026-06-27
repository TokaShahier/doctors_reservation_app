import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/appointment_repository.dart';

class BookAppointmentUseCase implements UseCase<void, BookAppointmentParams> {
  final AppointmentRepository repository;

  BookAppointmentUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(BookAppointmentParams params) async {
    return await repository.bookAppointment(params.doctorId, params.doctorName, params.date);
  }
}

class BookAppointmentParams extends Equatable {
  final String doctorId;
  final String doctorName;
  final DateTime date;

  const BookAppointmentParams({required this.doctorId, required this.doctorName, required this.date});

  @override
  List<Object> get props => [doctorId, doctorName, date];
}
