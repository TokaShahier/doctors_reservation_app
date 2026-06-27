import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/presentation/widgets/primary_button.dart';
import '../../../doctors/domain/entities/doctor_entity.dart';
import '../bloc/appointment_bloc.dart';
import '../bloc/appointment_event.dart';
import '../bloc/appointment_state.dart';

class BookAppointmentPage extends StatefulWidget {
  final DoctorEntity doctor;

  const BookAppointmentPage({super.key, required this.doctor});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: BlocConsumer<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentBookedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Appointment booked!')),
            );
            context.go('/home');
          } else if (state is AppointmentError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.1),
                      backgroundImage: widget.doctor.imageUrl != null
                          ? NetworkImage(widget.doctor.imageUrl!)
                          : null,
                      child: widget.doctor.imageUrl == null
                          ? Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                    ),
                    title: Text(
                      widget.doctor.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(widget.doctor.specialty),
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Select Date & Time',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          selectedDate == null
                              ? 'Choose Date'
                              : DateFormat(
                                  'EEEE, MMM d, yyyy',
                                ).format(selectedDate!),
                        ),
                        leading: const Icon(Icons.calendar_today),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().add(
                              const Duration(days: 1),
                            ),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 60),
                            ),
                          );
                          if (date != null) setState(() => selectedDate = date);
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        title: Text(
                          selectedTime == null
                              ? 'Choose Time'
                              : selectedTime!.format(context),
                        ),
                        leading: const Icon(Icons.access_time),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 9, minute: 0),
                          );
                          if (time != null) setState(() => selectedTime = time);
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  text: 'Confirm Booking',
                  isLoading: state is AppointmentLoading,
                  onPressed: () {
                    if (selectedDate == null || selectedTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select both date and time'),
                        ),
                      );
                      return;
                    }
                    final appointmentDateTime = DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      selectedTime!.hour,
                      selectedTime!.minute,
                    );
                    context.read<AppointmentBloc>().add(
                      BookAppointmentEvent(
                        doctorId: widget.doctor.id,
                        doctorName: widget.doctor.name,
                        date: appointmentDateTime,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
