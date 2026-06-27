<div align="center">

# 🏥 Doctors Reservation App

**A full-featured, production-ready Flutter application for booking doctor appointments — built with Clean Architecture, BLoC, and Supabase.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Supabase](https://img.shields.io/badge/Supabase-Backend-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com)
[![BLoC](https://img.shields.io/badge/BLoC-State%20Management-FF6B35?style=for-the-badge)](https://bloclibrary.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

[Features](#-features) · [Architecture](#-architecture) · [Tech Stack](#-tech-stack) · [Getting Started](#-getting-started) · [Supabase Setup](#-supabase-setup) · [Folder Structure](#-folder-structure)

</div>

---

## 📖 Overview

**Doctors Reservation App** is a polished Flutter mobile application that allows patients to discover doctors, view profiles, and schedule appointments — all in real time. Built with scalability and maintainability in mind, it follows **Clean Architecture** principles and uses **BLoC** for predictable state management backed by **Supabase** as the backend-as-a-service platform.

This project serves as a comprehensive portfolio piece demonstrating modern Flutter development practices, including secure authentication, real-time data, image caching, and a clean separation of concerns across feature modules.

---

## ✨ Features

### 🔐 Authentication
- **Email & Password** sign-up / sign-in
- **Forgot Password** flow with email link
- **Password Reset** via deep link
- **Splash screen** with automatic auth state detection

### 🩺 Doctors
- **Browse** all available doctors with specialty and photo
- **Search** doctors by name in real time
- **Doctor Detail** page with full bio and specialty
- **Doctor images** loaded from Supabase Storage with caching

### 📅 Appointments
- **Book appointments** by selecting date & time
- **View upcoming** appointments
- **Cancel** upcoming appointments
- **Booking history** with status badges (Upcoming / Cancelled / Completed)

### 👤 Profile
- **View** profile information
- **Edit** display name
- Quick access to **Booking History**

### 🎨 UI / UX
- Material 3 design system with a **deep teal** color palette
- Smooth navigation via bottom `NavigationBar`
- `CachedNetworkImage` for fast, offline-resilient doctor photos
- Loading skeletons (shimmer), empty states, and error states throughout
- Fully responsive layouts

---

## 📸 Screenshots

> _Run the app and add your screenshots here._

| Splash | Login | Doctors List | Doctor Details |
|--------|-------|--------------|----------------|
| ![Splash](screenshots/splash.png) | ![Login](screenshots/login.png) | ![Doctors](screenshots/doctors_list.png) | ![Details](screenshots/doctor_details.png) |

| Book Appointment | Upcoming Appointments | Booking History | Profile |
|-----------------|----------------------|----------------|---------|
| ![Book](screenshots/book_appointment.png) | ![Upcoming](screenshots/upcoming.png) | ![History](screenshots/history.png) | ![Profile](screenshots/profile.png) |

> 💡 Place your screenshots in a `screenshots/` folder at the project root.

---

## 🏛️ Architecture

This project strictly follows **Clean Architecture** with a feature-first folder structure. Each feature is self-contained with three layers:

```
┌─────────────────────────────────────────────┐
│              Presentation Layer             │
│         (BLoC · Pages · Widgets)            │
├─────────────────────────────────────────────┤
│               Domain Layer                  │
│      (Entities · Use Cases · Repo Contracts)│
├─────────────────────────────────────────────┤
│                Data Layer                   │
│    (Models · Repositories · Data Sources)   │
└─────────────────────────────────────────────┘
             ↕  via dependency injection (GetIt)
┌─────────────────────────────────────────────┐
│              External Services              │
│           Supabase (Auth + DB + Storage)    │
└─────────────────────────────────────────────┘
```

### Data Flow

```
UI Event → BLoC → Use Case → Repository → Data Source → Supabase
                                                           ↓
UI State ← BLoC ← Either<Failure, Data> ←─────────────────┘
```

### Key Patterns

| Pattern | Usage |
|---------|-------|
| **BLoC** | All state management (Events → States) |
| **Repository Pattern** | Decouples data sources from business logic |
| **Use Cases** | Single-responsibility business operations |
| **Dependency Injection** | `GetIt` service locator via `injection_container.dart` |
| **Functional Error Handling** | `Either<Failure, T>` via `dartz` |
| **Declarative Routing** | `GoRouter` with type-safe `extra` parameters |

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| **Framework** | [Flutter](https://flutter.dev) 3.x / Dart 3.x |
| **Backend** | [Supabase](https://supabase.com) (Auth, PostgreSQL, Storage) |
| **State Management** | [flutter_bloc](https://bloclibrary.dev) |
| **Routing** | [go_router](https://pub.dev/packages/go_router) |
| **Dependency Injection** | [get_it](https://pub.dev/packages/get_it) |
| **Image Caching** | [cached_network_image](https://pub.dev/packages/cached_network_image) |
| **Functional Programming** | [dartz](https://pub.dev/packages/dartz) |
| **Equality** | [equatable](https://pub.dev/packages/equatable) |
| **Loading Effects** | [shimmer](https://pub.dev/packages/shimmer) |
| **Date Formatting** | [intl](https://pub.dev/packages/intl) |
| **Fonts** | [google_fonts](https://pub.dev/packages/google_fonts) |
| **SVG Support** | [flutter_svg](https://pub.dev/packages/flutter_svg) |

---

## 📁 Folder Structure

```
lib/
├── main.dart                        # App entry point, Supabase init, BLoC providers
│
├── core/                            # Shared infrastructure
│   ├── constants/
│   │   └── app_constants.dart       # Supabase URL & anon key (dart-define)
│   ├── di/
│   │   └── injection_container.dart # GetIt dependency registration
│   ├── error/
│   │   └── failures.dart            # Failure types (ServerFailure, etc.)
│   ├── presentation/
│   │   └── widgets/                 # Reusable UI: buttons, loaders, empty states
│   ├── routing/
│   │   └── app_router.dart          # GoRouter config + MainWrapperPage (bottom nav)
│   ├── theme/
│   │   └── app_theme.dart           # Material 3 theme, color palette, typography
│   └── usecases/
│       └── usecase.dart             # Base UseCase abstract class
│
└── features/
    ├── auth/                        # Authentication feature
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │       ├── bloc/                # AuthBloc, AuthEvent, AuthState
    │       └── pages/               # SplashPage, LoginPage, RegisterPage,
    │                                # ForgotPasswordPage, ResetPasswordPage
    │
    ├── doctors/                     # Doctors feature
    │   ├── data/
    │   │   ├── datasources/         # DoctorRemoteDataSource (Supabase)
    │   │   ├── models/              # DoctorModel (JSON ↔ Entity)
    │   │   └── repositories/        # DoctorRepositoryImpl
    │   ├── domain/
    │   │   ├── entities/            # DoctorEntity
    │   │   ├── repositories/        # DoctorRepository (abstract)
    │   │   └── usecases/            # GetDoctorsUseCase, SearchDoctorsUseCase
    │   └── presentation/
    │       ├── bloc/                # DoctorBloc, DoctorEvent, DoctorState
    │       ├── pages/               # DoctorsListPage, DoctorDetailsPage
    │       └── widgets/             # DoctorCard
    │
    ├── appointments/                # Appointments feature
    │   ├── data/
    │   │   ├── datasources/         # AppointmentRemoteDataSource
    │   │   ├── models/              # AppointmentModel
    │   │   └── repositories/        # AppointmentRepositoryImpl
    │   ├── domain/
    │   │   ├── entities/            # AppointmentEntity
    │   │   ├── repositories/        # AppointmentRepository (abstract)
    │   │   └── usecases/            # BookAppointmentUseCase, etc.
    │   └── presentation/
    │       ├── bloc/                # AppointmentBloc
    │       ├── pages/               # BookAppointmentPage, UpcomingAppointmentsPage
    │       └── widgets/             # AppointmentCard
    │
    └── profile/                     # Profile feature
        ├── data/
        │   ├── datasources/         # ProfileRemoteDataSource
        │   ├── models/              # ProfileModel
        │   └── repositories/        # ProfileRepositoryImpl
        ├── domain/
        │   ├── entities/            # ProfileEntity
        │   ├── repositories/        # ProfileRepository (abstract)
        │   └── usecases/            # GetProfileUseCase, UpdateProfileUseCase,
        │                            # GetBookingHistoryUseCase
        └── presentation/
            ├── bloc/                # ProfileBloc
            └── pages/               # ProfilePage, EditProfilePage, BookingHistoryPage
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) **3.x or later**
- [Dart SDK](https://dart.dev/get-dart) **3.x or later**
- A [Supabase](https://supabase.com) account and project
- An IDE: [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### 1. Clone the repository

```bash
git clone https://github.com/your-username/doctors_app.git
cd doctors_app
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure environment variables

This project uses `--dart-define` to securely pass secrets at build time. **Never hardcode credentials.**

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key-here
```

> 💡 **VS Code tip:** Create a `.vscode/launch.json` file:
> ```json
> {
>   "version": "0.2.0",
>   "configurations": [
>     {
>       "name": "doctors_app",
>       "request": "launch",
>       "type": "dart",
>       "args": [
>         "--dart-define=SUPABASE_URL=https://your-project.supabase.co",
>         "--dart-define=SUPABASE_ANON_KEY=your-anon-key-here"
>       ]
>     }
>   ]
> }
> ```

### 4. Run the app

```bash
flutter run
```

---

## ⚙️ Supabase Setup

### Step 1 — Create a Supabase Project

1. Go to [supabase.com](https://supabase.com) and create a new project.
2. Copy your **Project URL** and **anon/public key** from **Settings → API**.

### Step 2 — Create the `doctors` Table

```sql
CREATE TABLE public.doctors (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT NOT NULL,
  specialty  TEXT NOT NULL,
  bio        TEXT,
  image_url  TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE public.doctors ENABLE ROW LEVEL SECURITY;

-- Allow all authenticated users to read doctors
CREATE POLICY "Authenticated users can view doctors"
  ON public.doctors FOR SELECT
  USING (auth.role() = 'authenticated');
```

### Step 3 — Create the `appointments` Table

```sql
CREATE TABLE public.appointments (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  doctor_id        UUID REFERENCES public.doctors(id),
  doctor_name      TEXT NOT NULL,
  patient_id       UUID REFERENCES auth.users(id),
  appointment_date TIMESTAMPTZ NOT NULL,
  status           TEXT NOT NULL DEFAULT 'upcoming',
  created_at       TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE public.appointments ENABLE ROW LEVEL SECURITY;

-- Users can only manage their own appointments
CREATE POLICY "Users manage own appointments"
  ON public.appointments FOR ALL
  USING (auth.uid() = patient_id);
```

### Step 4 — Set Up Storage for Doctor Images

1. In your Supabase dashboard, go to **Storage**.
2. Create a new bucket named **`doctor-images`**.
3. Set the bucket to **Public**.
4. Upload doctor images (JPG/PNG) to the bucket.
5. Store the image **filename** (e.g., `dr-smith.jpg`) in the `doctors.image_url` column — the app constructs the full public URL automatically.

> The public URL format is:
> `https://<your-project>.supabase.co/storage/v1/object/public/doctor-images/<filename>`

### Step 5 — Enable Authentication

1. In Supabase, go to **Authentication → Providers**.
2. Ensure **Email** provider is enabled.
3. For password reset, configure your **Site URL** and **Redirect URLs** under **Authentication → URL Configuration**.

### Step 6 — Seed Sample Data _(Optional)_

```sql
INSERT INTO public.doctors (name, specialty, bio, image_url) VALUES
  ('Dr. Sarah Mitchell', 'Cardiologist',
   'Dr. Mitchell has over 15 years of experience in cardiovascular medicine.',
   'dr-sarah-mitchell.jpg'),
  ('Dr. James Carter', 'Neurologist',
   'Specialist in neurological disorders with a focus on stroke prevention.',
   'dr-james-carter.jpg'),
  ('Dr. Emily Chen', 'Dermatologist',
   'Expert in clinical and cosmetic dermatology.',
   'dr-emily-chen.jpg');
```

---

## 🔮 Future Improvements

- [ ] **Push Notifications** — Appointment reminders via FCM
- [ ] **Doctor Ratings & Reviews** — Star ratings from past patients
- [ ] **Filter by Specialty** — Filter/sort doctors on the list page
- [ ] **Appointment Rescheduling** — Modify existing appointments
- [ ] **Video Consultation** — In-app telemedicine via WebRTC
- [ ] **Multi-language Support** — i18n with `flutter_localizations`
- [ ] **Dark Mode** — Full dark theme support
- [ ] **Offline Support** — Local caching with `sqflite` or `Hive`
- [ ] **Unit & Widget Tests** — Comprehensive test coverage with mocks
- [ ] **CI/CD Pipeline** — Automated testing and deployment via GitHub Actions

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'feat: add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

<div align="center">

Made with ❤️ using Flutter & Supabase

⭐ Star this repo if you found it helpful!

</div>
