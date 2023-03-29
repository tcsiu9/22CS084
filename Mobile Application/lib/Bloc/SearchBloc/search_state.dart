part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String error;

  const SearchError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SearchError {$error}';
}

class SearchLoaded extends SearchState {
  const SearchLoaded({
    this.search = const <String, dynamic> {},
  });

  final Map<String, dynamic> search;

  SearchLoaded copyWith({Map<String, dynamic>? search}) {
    return SearchLoaded(
      search: search ?? this.search,
    );
  }

  @override
  List<Object> get props => [search];
}
