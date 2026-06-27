Project: Doctors Reservation App

Tech Stack:
- Flutter
- BLoC
- Clean Architecture
- Repository Pattern
- Supabase Backend
- get_it Dependency Injection
- GoRouter Navigation
- Material 3

Features:

Authentication:
- Sign Up
- Login
- Forgot Password
- Logout

Doctors:
- Doctors List
- Search Doctors
- Doctor Details

Appointments:
- Book Appointment
- Cancel Appointment
- Upcoming Appointments

Profile:
- View Profile
- Edit Profile
- Booking History

Architecture:

lib/
 ├── core/
 ├── shared/
 ├── features/
 │   ├── auth/
 │   ├── doctors/
 │   ├── appointments/
 │   └── profile/
 └── main.dart

Rules:
- Use BLoC only
- No business logic inside UI
- Follow Clean Architecture
- Use Supabase for backend
- Generate production-ready code