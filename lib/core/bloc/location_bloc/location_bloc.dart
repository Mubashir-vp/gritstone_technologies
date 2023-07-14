import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gritstone_technologies/core/model/local_db/location_model/location_model.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<LoadData>((event, emit) {
      // TODO: implement event handler
    });
  }
}
