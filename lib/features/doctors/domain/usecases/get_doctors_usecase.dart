import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor_entity.dart';
import '../repositories/doctor_repository.dart';

class GetDoctorsUseCase implements UseCase<List<DoctorEntity>, NoParams> {
  final DoctorRepository repository;

  GetDoctorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(NoParams params) async {
    return await repository.getDoctors();
  }
}
