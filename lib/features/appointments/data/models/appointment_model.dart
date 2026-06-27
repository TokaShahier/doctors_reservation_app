import '../../domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  const AppointmentModel({
    required super.id,
    required super.doctorId,
    required super.doctorName,
    required super.patientId,
    required super.appointmentDate,
    required super.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      doctorId: json['doctor_id'] as String,
      doctorName: json['doctor_name'] as String,
      patientId: json['patient_id'] as String,
      appointmentDate: DateTime.parse(json['appointment_date'] as String),
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'patient_id': patientId,
      'appointment_date': appointmentDate.toIso8601String(),
      'status': status,
    };
  }
}
