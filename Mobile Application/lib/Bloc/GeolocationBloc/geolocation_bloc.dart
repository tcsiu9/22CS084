import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fyp_app/repositories/geolocation_repositories.dart';
import 'package:geolocator/geolocator.dart';

part 'geolocation_event.dart';

part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepositories geolocationRepositories;
  StreamSubscription? _geolocationSubscription;

  GeolocationBloc({required this.geolocationRepositories})
      : assert(geolocationRepositories != null),
        super(GeolocationLoading()) {
    on<LoadGeolocation>((event, emit) async {
      _geolocationSubscription?.cancel();
      final Stream<Position> streamPosition =
          await geolocationRepositories.getCurrentLocation();
      final Position sourcePosition = await geolocationRepositories.getSourceLocation();
      // emit(GeolocationLoaded(position: position));
      streamPosition.listen((Position position) {
        add(UpdateGeolocation(curPosition: position, sourcePosition: sourcePosition));
      });
    });
    on<UpdateGeolocation>((event, emit) {
      emit(GeolocationLoaded(curPosition: event.curPosition, sourcePosition: event.sourcePosition));
    });
  }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
