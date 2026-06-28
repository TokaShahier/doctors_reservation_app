import 'dart:typed_data';
import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String name;

  const UpdateProfileEvent({required this.name});

  @override
  List<Object> get props => [name];
}

class GetBookingHistoryEvent extends ProfileEvent {}

class UpdateAvatarEvent extends ProfileEvent {
  final Uint8List? bytes;
  final String? fileName;

  const UpdateAvatarEvent({this.bytes, this.fileName});

  @override
  List<Object?> get props => [bytes, fileName];
}
