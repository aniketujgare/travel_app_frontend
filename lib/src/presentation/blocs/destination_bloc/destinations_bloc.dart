import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/src/data/datasources/api.dart';
import 'package:travel_app/src/domain/models/destination_model.dart';

part 'destinations_event.dart';
part 'destinations_state.dart';

class DestinationsBloc extends Bloc<DestinationsEvent, DestinationsState> {
  List<DestinationModel>? destinations;
  DestinationsBloc() : super(DestinationsInitial()) {
    on<GetDestinationsEvent>((event, emit) async {
      emit(DestinationsLoading());
      try {
        var dn = await ApiService().getDestinations();
        destinations = dn;
        emit(DestinationsLoaded(destinationList: dn!));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
