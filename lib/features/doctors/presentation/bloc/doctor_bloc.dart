import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_doctors_usecase.dart';
import '../../domain/usecases/search_doctors_usecase.dart';
import 'doctor_event.dart';
import 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetDoctorsUseCase getDoctorsUseCase;
  final SearchDoctorsUseCase searchDoctorsUseCase;

  DoctorBloc({
    required this.getDoctorsUseCase,
    required this.searchDoctorsUseCase,
  }) : super(DoctorInitial()) {
    on<FetchDoctors>(_onFetchDoctors);
    on<SearchDoctors>(_onSearchDoctors);
  }

  Future<void> _onFetchDoctors(FetchDoctors event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    final result = await getDoctorsUseCase(const NoParams());
    result.fold(
      (failure) => emit(DoctorError(failure.message)),
      (doctors) => emit(DoctorLoaded(doctors)),
    );
  }

  Future<void> _onSearchDoctors(SearchDoctors event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    final result = await searchDoctorsUseCase(SearchDoctorsParams(query: event.query));
    result.fold(
      (failure) => emit(DoctorError(failure.message)),
      (doctors) => emit(DoctorLoaded(doctors)),
    );
  }
}
