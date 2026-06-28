import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../appointments/domain/entities/appointment_entity.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();

  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    String? avatarUrl,
  });

  Future<Either<Failure, List<AppointmentEntity>>> getBookingHistory();

  Future<Either<Failure, ProfileEntity>> updateAvatar({
    Uint8List? bytes,
    String? fileName,
  });
}
