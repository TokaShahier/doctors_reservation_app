import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/doctor_entity.dart';

class DoctorDetailsPage extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorDetailsPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(doctor.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: doctor.imageUrl != null
                    ? NetworkImage(doctor.imageUrl!)
                    : null,
                child: doctor.imageUrl == null
                    ? const Icon(Icons.person, size: 60)
                    : null,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              doctor.name,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              doctor.specialty,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.blueGrey),
            ),
            const SizedBox(height: 24),
            const Text(
              'About',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              doctor.bio ?? 'No bio available.',
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/book-appointment', extra: doctor);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Book Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
