import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/check_auth_status.dart';
import '../../features/auth/domain/usecases/update_password_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/doctors/data/datasources/doctor_remote_data_source.dart';
import '../../features/doctors/data/repositories/doctor_repository_impl.dart';
import '../../features/doctors/domain/repositories/doctor_repository.dart';
import '../../features/doctors/domain/usecases/get_doctors_usecase.dart';
import '../../features/doctors/domain/usecases/search_doctors_usecase.dart';
import '../../features/doctors/presentation/bloc/doctor_bloc.dart';
import '../../features/appointments/data/datasources/appointment_remote_data_source.dart';
import '../../features/appointments/data/repositories/appointment_repository_impl.dart';
import '../../features/appointments/domain/repositories/appointment_repository.dart';
import '../../features/appointments/domain/usecases/book_appointment_usecase.dart';
import '../../features/appointments/domain/usecases/cancel_appointment_usecase.dart';
import '../../features/appointments/domain/usecases/get_upcoming_appointments_usecase.dart';
import '../../features/appointments/presentation/bloc/appointment_bloc.dart';
import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_booking_history_usecase.dart';
import '../../features/profile/domain/usecases/get_profile_usecase.dart';
import '../../features/profile/domain/usecases/update_profile_usecase.dart';
import '../../features/profile/domain/usecases/update_avatar_usecase.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  
  // External
  sl.registerLazySingleton(() => Supabase.instance.client);
  
  // Features - Auth
  // Bloc
  sl.registerFactory(() => AuthBloc(
        loginUseCase: sl(),
        registerUseCase: sl(),
        logoutUseCase: sl(),
        forgotPasswordUseCase: sl(),
        checkAuthStatus: sl(),
        updatePasswordUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthStatus(sl()));
  sl.registerLazySingleton(() => UpdatePasswordUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));

  // Features - Doctors
  // Bloc
  sl.registerFactory(() => DoctorBloc(
        getDoctorsUseCase: sl(),
        searchDoctorsUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetDoctorsUseCase(sl()));
  sl.registerLazySingleton(() => SearchDoctorsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<DoctorRepository>(
      () => DoctorRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<DoctorRemoteDataSource>(
      () => DoctorRemoteDataSourceImpl(sl()));

  // Features - Appointments
  // Bloc
  sl.registerFactory(() => AppointmentBloc(
        bookAppointmentUseCase: sl(),
        cancelAppointmentUseCase: sl(),
        getUpcomingAppointmentsUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => BookAppointmentUseCase(sl()));
  sl.registerLazySingleton(() => CancelAppointmentUseCase(sl()));
  sl.registerLazySingleton(() => GetUpcomingAppointmentsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<AppointmentRemoteDataSource>(
      () => AppointmentRemoteDataSourceImpl(sl()));

  // Features - Profile
  // Bloc
  sl.registerFactory(() => ProfileBloc(
        getProfileUseCase: sl(),
        updateProfileUseCase: sl(),
        getBookingHistoryUseCase: sl(),
        updateAvatarUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => GetBookingHistoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateAvatarUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(sl()));
}
