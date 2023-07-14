part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends LocationEvent {
  const LoadData();
  @override
  List<Object> get props => [];
}
