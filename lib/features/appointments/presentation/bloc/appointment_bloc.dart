import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/book_appointment_usecase.dart';
import '../../domain/usecases/cancel_appointment_usecase.dart';
import '../../domain/usecases/get_upcoming_appointments_usecase.dart';
import 'appointment_event.dart';
import 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final BookAppointmentUseCase bookAppointmentUseCase;
  final CancelAppointmentUseCase cancelAppointmentUseCase;
  final GetUpcomingAppointmentsUseCase getUpcomingAppointmentsUseCase;

  AppointmentBloc({
    required this.bookAppointmentUseCase,
    required this.cancelAppointmentUseCase,
    required this.getUpcomingAppointmentsUseCase,
  }) : super(AppointmentInitial()) {
    on<BookAppointmentEvent>(_onBookAppointment);
    on<CancelAppointmentEvent>(_onCancelAppointment);
    on<GetUpcomingAppointmentsEvent>(_onGetUpcomingAppointments);
  }

  Future<void> _onBookAppointment(BookAppointmentEvent event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    final result = await bookAppointmentUseCase(
      BookAppointmentParams(doctorId: event.doctorId, doctorName: event.doctorName, date: event.date),
    );
    result.fold(
      (failure) => emit(AppointmentError(failure.message)),
      (_) => emit(AppointmentBookedSuccess()),
    );
  }

  Future<void> _onCancelAppointment(CancelAppointmentEvent event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    final result = await cancelAppointmentUseCase(CancelAppointmentParams(appointmentId: event.appointmentId));
    result.fold(
      (failure) => emit(AppointmentError(failure.message)),
      (_) => emit(AppointmentCancelledSuccess()),
    );
  }

  Future<void> _onGetUpcomingAppointments(GetUpcomingAppointmentsEvent event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    final result = await getUpcomingAppointmentsUseCase(const NoParams());
    result.fold(
      (failure) => emit(AppointmentError(failure.message)),
      (appointments) => emit(UpcomingAppointmentsLoaded(appointments)),
    );
  }
}
