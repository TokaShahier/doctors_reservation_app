import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class BookAppointmentEvent extends AppointmentEvent {
  final String doctorId;
  final String doctorName;
  final DateTime date;

  const BookAppointmentEvent({required this.doctorId, required this.doctorName, required this.date});

  @override
  List<Object> get props => [doctorId, doctorName, date];
}

class CancelAppointmentEvent extends AppointmentEvent {
  final String appointmentId;

  const CancelAppointmentEvent(this.appointmentId);

  @override
  List<Object> get props => [appointmentId];
}

class GetUpcomingAppointmentsEvent extends AppointmentEvent {}
