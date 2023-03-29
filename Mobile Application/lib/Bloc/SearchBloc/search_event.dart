part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchSubmitted extends SearchEvent {
  final String uuid;

  const SearchSubmitted({required this.uuid});

  @override
  List<Object> get props => [uuid];

  @override
  String toString() => 'SearchSubmitted {$uuid}';
}

class SearchRefreshed extends SearchEvent {}

class ReturnLogin extends SearchEvent {}
