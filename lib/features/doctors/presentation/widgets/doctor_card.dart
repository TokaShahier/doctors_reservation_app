import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/doctor_entity.dart';

class DoctorCard extends StatelessWidget {
  final DoctorEntity doctor;

  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => context.push('/doctor-details', extra: doctor),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  image: doctor.imageUrl != null
                      ? DecorationImage(
                          image: NetworkImage(doctor.imageUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: doctor.imageUrl == null
                    ? Icon(
                        Icons.person,
                        size: 40,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialty,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}
