import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const RegisterRequested({required this.email, required this.password, required this.name});

  @override
  List<Object> get props => [email, password, name];
}

class LogoutRequested extends AuthEvent {}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}

class CheckAuthStatusRequested extends AuthEvent {
  const CheckAuthStatusRequested();

  @override
  List<Object> get props => [];
}

class UpdatePasswordRequested extends AuthEvent {
  final String password;

  const UpdatePasswordRequested({required this.password});

  @override
  List<Object> get props => [password];
}


