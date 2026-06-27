import 'package:equatable/equatable.dart';

class DoctorEntity extends Equatable {
  final String id;
  final String name;
  final String specialty;
  final String? imageUrl;
  final String? bio;

  const DoctorEntity({
    required this.id,
    required this.name,
    required this.specialty,
    this.imageUrl,
    this.bio,
  });

  @override
  List<Object?> get props => [id, name, specialty, imageUrl, bio];
}
