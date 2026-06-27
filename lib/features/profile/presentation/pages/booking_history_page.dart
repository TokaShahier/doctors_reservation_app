import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/presentation/widgets/custom_loading_indicator.dart';
import '../../../../core/presentation/widgets/empty_state_widget.dart';
import '../../../../core/presentation/widgets/error_state_widget.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({super.key});

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetBookingHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking History')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const CustomLoadingIndicator();
          } else if (state is BookingHistoryLoaded) {
            if (state.history.isEmpty) {
              return const EmptyStateWidget(
                icon: Icons.history,
                message: 'No booking history found.',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                final appointment = state.history[index];
                final bool isUpcoming = appointment.status == 'upcoming';
                final Color statusColor = isUpcoming
                    ? Colors.green.shade600
                    : (appointment.status == 'cancelled'
                          ? Colors.red.shade600
                          : Colors.grey.shade600);

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    title: Text(
                      'Dr. ${appointment.doctorName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        DateFormat(
                          'EEEE, MMM d, yyyy • h:mm a',
                        ).format(appointment.appointmentDate),
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        appointment.status.toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is ProfileError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () =>
                  context.read<ProfileBloc>().add(GetBookingHistoryEvent()),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
