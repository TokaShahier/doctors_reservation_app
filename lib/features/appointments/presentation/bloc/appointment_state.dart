import 'package:equatable/equatable.dart';
import '../../domain/entities/appointment_entity.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentBookedSuccess extends AppointmentState {}

class AppointmentCancelledSuccess extends AppointmentState {}

class UpcomingAppointmentsLoaded extends AppointmentState {
  final List<AppointmentEntity> appointments;

  const UpcomingAppointmentsLoaded(this.appointments);

  @override
  List<Object> get props => [appointments];
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError(this.message);

  @override
  List<Object> get props => [message];
}
