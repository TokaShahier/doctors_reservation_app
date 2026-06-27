import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  final String id;
  final String doctorId;
  final String doctorName;
  final String patientId;
  final DateTime appointmentDate;
  final String status; // 'upcoming', 'cancelled', 'completed'

  const AppointmentEntity({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.patientId,
    required this.appointmentDate,
    required this.status,
  });

  @override
  List<Object> get props => [id, doctorId, doctorName, patientId, appointmentDate, status];
}
