import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase implements UseCase<ProfileEntity, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(UpdateProfileParams params) async {
    return await repository.updateProfile(params.name);
  }
}

class UpdateProfileParams extends Equatable {
  final String name;

  const UpdateProfileParams({required this.name});

  @override
  List<Object> get props => [name];
}
