import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/routing/app_router.dart';
import 'core/di/injection_container.dart' as di;
import 'core/constants/app_constants.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/doctors/presentation/bloc/doctor_bloc.dart';
import 'features/appointments/presentation/bloc/appointment_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase using secure constants
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    publishableKey: AppConstants.supabaseAnonKey,
  );

  // Initialize Dependency Injection
  await di.init();

  // Listen to Supabase auth state changes for password recovery
  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final event = data.event;
    if (event == AuthChangeEvent.passwordRecovery) {
      appRouter.go('/reset-password');
    }
  });

  runApp(const DoctorsApp());
}

class DoctorsApp extends StatelessWidget {
  const DoctorsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(const CheckAuthStatusRequested()),
        ),
        BlocProvider(create: (_) => di.sl<DoctorBloc>()),
        BlocProvider(create: (_) => di.sl<AppointmentBloc>()),
        BlocProvider(create: (_) => di.sl<ProfileBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Doctors Reservation',
        theme: AppTheme.themeData,
        routerConfig: appRouter,
      ),
    );
  }
}
