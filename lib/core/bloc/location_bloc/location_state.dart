part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class DataLoaded extends LocationState {
  final List<LocationModel> locationModle;

  const DataLoaded({
    required this.locationModle,
  });
  @override
  List<Object> get props => [
        locationModle,
      ];
}
