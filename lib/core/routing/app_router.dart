import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/doctors/presentation/pages/doctors_list_page.dart';
import '../../features/doctors/presentation/pages/doctor_details_page.dart';
import '../../features/doctors/domain/entities/doctor_entity.dart';
import '../../features/appointments/presentation/pages/book_appointment_page.dart';
import '../../features/appointments/presentation/pages/upcoming_appointments_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/booking_history_page.dart';
import '../../features/profile/domain/entities/profile_entity.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/reset-password',
      builder: (context, state) => const ResetPasswordPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainWrapperPage(),
    ),
    GoRoute(
      path: '/doctor-details',
      builder: (context, state) {
        final doctor = state.extra as DoctorEntity;
        return DoctorDetailsPage(doctor: doctor);
      },
    ),
    GoRoute(
      path: '/book-appointment',
      builder: (context, state) {
        final doctor = state.extra as DoctorEntity;
        return BookAppointmentPage(doctor: doctor);
      },
    ),
    GoRoute(
      path: '/appointments',
      builder: (context, state) => const UpcomingAppointmentsPage(),
    ),
    GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) {
        final profile = state.extra as ProfileEntity;
        return EditProfilePage(profile: profile);
      },
    ),
    GoRoute(
      path: '/booking-history',
      builder: (context, state) => const BookingHistoryPage(),
    ),
  ],
);

class MainWrapperPage extends StatefulWidget {
  const MainWrapperPage({super.key});

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DoctorsListPage(),
    UpcomingAppointmentsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.local_hospital_outlined),
            selectedIcon: Icon(Icons.local_hospital),
            label: 'Doctors',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
