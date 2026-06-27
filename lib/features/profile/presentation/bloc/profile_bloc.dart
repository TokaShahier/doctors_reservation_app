import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_booking_history_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetBookingHistoryUseCase getBookingHistoryUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.getBookingHistoryUseCase,
  }) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<GetBookingHistoryEvent>(_onGetBookingHistory);
  }

  Future<void> _onGetProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await getProfileUseCase(const NoParams());
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  Future<void> _onUpdateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await updateProfileUseCase(UpdateProfileParams(name: event.name));
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileUpdateSuccess(profile)),
    );
  }

  Future<void> _onGetBookingHistory(GetBookingHistoryEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await getBookingHistoryUseCase(const NoParams());
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (history) => emit(BookingHistoryLoaded(history)),
    );
  }
}
