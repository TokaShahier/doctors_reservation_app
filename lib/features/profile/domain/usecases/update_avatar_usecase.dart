import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateAvatarUseCase implements UseCase<ProfileEntity, UpdateAvatarParams> {
  final ProfileRepository repository;

  UpdateAvatarUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(UpdateAvatarParams params) async {
    return await repository.updateAvatar(
      bytes: params.bytes,
      fileName: params.fileName,
    );
  }
}

class UpdateAvatarParams extends Equatable {
  final Uint8List? bytes;
  final String? fileName;

  const UpdateAvatarParams({this.bytes, this.fileName});

  @override
  List<Object?> get props => [bytes, fileName];
}
