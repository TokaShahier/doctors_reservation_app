import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class UpdatePasswordUseCase implements UseCase<void, UpdatePasswordParams> {
  final AuthRepository repository;

  UpdatePasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdatePasswordParams params) async {
    return await repository.updatePassword(params.newPassword);
  }
}

class UpdatePasswordParams extends Equatable {
  final String newPassword;

  const UpdatePasswordParams({required this.newPassword});

  @override
  List<Object> get props => [newPassword];
}
