import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/widgets/custom_loading_indicator.dart';
import '../../../../core/presentation/widgets/empty_state_widget.dart';
import '../../../../core/presentation/widgets/error_state_widget.dart';
import '../bloc/doctor_bloc.dart';
import '../bloc/doctor_event.dart';
import '../bloc/doctor_state.dart';
import '../widgets/doctor_card.dart';

class DoctorsListPage extends StatefulWidget {
  const DoctorsListPage({super.key});

  @override
  State<DoctorsListPage> createState() => _DoctorsListPageState();
}

class _DoctorsListPageState extends State<DoctorsListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DoctorBloc>().add(FetchDoctors());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Doctor'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search doctors...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  context.read<DoctorBloc>().add(FetchDoctors());
                } else {
                  context.read<DoctorBloc>().add(SearchDoctors(value));
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<DoctorBloc, DoctorState>(
              builder: (context, state) {
                if (state is DoctorLoading) {
                  return const CustomLoadingIndicator();
                } else if (state is DoctorError) {
                  return ErrorStateWidget(
                    message: state.message,
                    onRetry: () => context.read<DoctorBloc>().add(FetchDoctors()),
                  );
                } else if (state is DoctorLoaded) {
                  if (state.doctors.isEmpty) {
                    return const EmptyStateWidget(
                      icon: Icons.person_search,
                      message: 'No doctors found.\nTry a different search term.',
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.doctors.length,
                    itemBuilder: (context, index) {
                      return DoctorCard(doctor: state.doctors[index]);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
