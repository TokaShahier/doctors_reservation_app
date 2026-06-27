import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failures.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<void> logout();
  Future<void> forgotPassword(String email);
  Future<UserModel?> getCurrentUser();
  Future<void> updatePassword(String newPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const ServerFailure('Login failed. User not found.');
      }
      return UserModel.fromSupabaseUser(response.user!);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      if (response.user == null) {
        throw const ServerFailure('Registration failed.');
      }
      return UserModel.fromSupabaseUser(response.user!);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.flutter://reset-password',
      );
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = supabaseClient.auth.currentUser;
    if (user != null) {
      return UserModel.fromSupabaseUser(user);
    }
    return null;
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      await supabaseClient.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
