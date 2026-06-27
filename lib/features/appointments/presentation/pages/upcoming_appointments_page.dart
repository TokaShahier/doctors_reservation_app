import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/widgets/custom_loading_indicator.dart';
import '../../../../core/presentation/widgets/empty_state_widget.dart';
import '../../../../core/presentation/widgets/error_state_widget.dart';
import '../bloc/appointment_bloc.dart';
import '../bloc/appointment_event.dart';
import '../bloc/appointment_state.dart';
import '../widgets/appointment_card.dart';

class UpcomingAppointmentsPage extends StatefulWidget {
  const UpcomingAppointmentsPage({super.key});

  @override
  State<UpcomingAppointmentsPage> createState() => _UpcomingAppointmentsPageState();
}

class _UpcomingAppointmentsPageState extends State<UpcomingAppointmentsPage> {
  @override
  void initState() {
    super.initState();
    context.read<AppointmentBloc>().add(GetUpcomingAppointmentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Appointments')),
      body: BlocConsumer<AppointmentBloc, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentCancelledSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment cancelled successfully.')));
            context.read<AppointmentBloc>().add(GetUpcomingAppointmentsEvent());
          } else if (state is AppointmentError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AppointmentLoading) {
            return const CustomLoadingIndicator();
          } else if (state is UpcomingAppointmentsLoaded) {
            if (state.appointments.isEmpty) {
              return const EmptyStateWidget(
                icon: Icons.event_busy,
                message: 'You have no upcoming appointments.',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.appointments.length,
              itemBuilder: (context, index) {
                return AppointmentCard(appointment: state.appointments[index]);
              },
            );
          } else if (state is AppointmentError) {
            return ErrorStateWidget(
              message: state.message,
              onRetry: () => context.read<AppointmentBloc>().add(GetUpcomingAppointmentsEvent()),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
