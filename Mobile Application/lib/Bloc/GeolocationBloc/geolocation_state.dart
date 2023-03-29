part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationLoading extends GeolocationState {}

class GeolocationLoaded extends GeolocationState {
  final Position curPosition;
  final Position sourcePosition;

  const GeolocationLoaded({required this.curPosition, required this.sourcePosition});

  @override
  List<Object> get props => [curPosition, sourcePosition];
}

class GeolocationError extends GeolocationState {
  final String error;

  const GeolocationError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'GeolocationError {$error}';
}
