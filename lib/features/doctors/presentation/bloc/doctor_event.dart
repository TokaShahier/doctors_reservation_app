import 'package:equatable/equatable.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

class FetchDoctors extends DoctorEvent {}

class SearchDoctors extends DoctorEvent {
  final String query;

  const SearchDoctors(this.query);

  @override
  List<Object> get props => [query];
}
