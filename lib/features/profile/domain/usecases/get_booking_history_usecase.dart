import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../appointments/domain/entities/appointment_entity.dart';
import '../repositories/profile_repository.dart';

class GetBookingHistoryUseCase implements UseCase<List<AppointmentEntity>, NoParams> {
  final ProfileRepository repository;

  GetBookingHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<AppointmentEntity>>> call(NoParams params) async {
    return await repository.getBookingHistory();
  }
}
