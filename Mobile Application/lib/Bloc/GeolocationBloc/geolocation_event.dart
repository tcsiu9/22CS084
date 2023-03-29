part of 'geolocation_bloc.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadGeolocation extends GeolocationEvent {}

class UpdateGeolocation extends GeolocationEvent {
  final Position curPosition;
  final Position sourcePosition;

  const UpdateGeolocation({required this.curPosition, required this.sourcePosition});

  @override
  List<Object?> get props => [curPosition, sourcePosition];
}
