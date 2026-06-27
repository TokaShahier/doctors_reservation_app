import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/appointment_entity.dart';
import '../bloc/appointment_bloc.dart';
import '../bloc/appointment_event.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentEntity appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final bool isUpcoming = appointment.status == 'upcoming';
    final Color statusColor = isUpcoming
        ? Colors.green.shade600
        : Colors.grey.shade600;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Dr. ${appointment.doctorName}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Container(
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
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat(
                    'EEEE, MMM d, yyyy',
                  ).format(appointment.appointmentDate),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  DateFormat('h:mm a').format(appointment.appointmentDate),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            if (isUpcoming) ...[
              const SizedBox(height: 16),
              const Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    context.read<AppointmentBloc>().add(
                      CancelAppointmentEvent(appointment.id),
                    );
                  },
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  label: const Text(
                    'Cancel Appointment',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
