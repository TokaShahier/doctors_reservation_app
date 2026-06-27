import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/presentation/widgets/custom_loading_indicator.dart';
import '../../../../core/presentation/widgets/error_state_widget.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
              context.go('/login');
            },
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const CustomLoadingIndicator();
          } else if (state is ProfileLoaded || state is ProfileUpdateSuccess) {
            final profile = state is ProfileLoaded
                ? state.profile
                : (state as ProfileUpdateSuccess).profile;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profile.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.email,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          title: const Text(
                            'Edit Profile',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            context.push('/edit-profile', extra: profile);
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.history,
                              color: Colors.orange.shade700,
                            ),
                          ),
                          title: const Text(
                            'Booking History',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () async {
                            await context.push('/booking-history');

                            if (context.mounted) {
                              context.read<ProfileBloc>().add(
                                GetProfileEvent(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<ProfileBloc>().add(GetProfileEvent()),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
