import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor_entity.dart';
import '../repositories/doctor_repository.dart';

class SearchDoctorsUseCase implements UseCase<List<DoctorEntity>, SearchDoctorsParams> {
  final DoctorRepository repository;

  SearchDoctorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<DoctorEntity>>> call(SearchDoctorsParams params) async {
    return await repository.searchDoctors(params.query);
  }
}

class SearchDoctorsParams extends Equatable {
  final String query;

  const SearchDoctorsParams({required this.query});

  @override
  List<Object> get props => [query];
}
