import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../appointments/domain/entities/appointment_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final profile = await remoteDataSource.getProfile();
      return Right(profile);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({
    required String name,
    String? avatarUrl,
  }) async {
    try {
      final profile = await remoteDataSource.updateProfile(
        name: name,
        avatarUrl: avatarUrl,
      );
      return Right(profile);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getBookingHistory() async {
    try {
      final history = await remoteDataSource.getBookingHistory();
      return Right(history);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateAvatar({
    Uint8List? bytes,
    String? fileName,
  }) async {
    try {
      // 1. Fetch current profile to get old avatar URL
      final currentProfile = await remoteDataSource.getProfile();
      final oldAvatarUrl = currentProfile.avatarUrl;

      String? newAvatarUrl;

      if (bytes != null && fileName != null) {
        // Upload new image
        newAvatarUrl = await remoteDataSource.uploadAvatar(
          bytes: bytes,
          fileName: fileName,
        );
      } else {
        // bytes == null indicates we want to remove the image (set to null)
        newAvatarUrl = null;
      }

      // 2. Update profiles.avatar_url in the database
      final updatedProfile = await remoteDataSource.updateAvatarUrl(newAvatarUrl);

      // 3. ONLY after database update succeeds, delete the old image from storage if it existed
      if (oldAvatarUrl != null && oldAvatarUrl.isNotEmpty) {
        final storagePath = _getStoragePathFromUrl(oldAvatarUrl);
        if (storagePath != null) {
          try {
            await remoteDataSource.deleteAvatar(storagePath: storagePath);
          } catch (_) {
            // Silently fail if deletion fails, as the new image is already successfully set in DB
          }
        }
      }

      return Right(updatedProfile);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  String? _getStoragePathFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      final avatarIndex = pathSegments.indexOf('avatars');
      if (avatarIndex != -1 && avatarIndex < pathSegments.length - 1) {
        return pathSegments.sublist(avatarIndex + 1).join('/');
      }
    } catch (_) {}
    return null;
  }
}
