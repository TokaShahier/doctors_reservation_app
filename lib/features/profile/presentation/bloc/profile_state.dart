import 'package:equatable/equatable.dart';
import '../../../../features/appointments/domain/entities/appointment_entity.dart';
import '../../domain/entities/profile_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  const ProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class ProfileUpdateSuccess extends ProfileState {
  final ProfileEntity profile;

  const ProfileUpdateSuccess(this.profile);

  @override
  List<Object> get props => [profile];
}

class BookingHistoryLoaded extends ProfileState {
  final List<AppointmentEntity> history;

  const BookingHistoryLoaded(this.history);

  @override
  List<Object> get props => [history];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}
