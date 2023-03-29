import 'dart:async';

import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:equatable/equatable.dart';
import 'package:fyp_app/repositories/user_repositories.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final UserRepositories userRepositories;
  Map<String, dynamic> search = {};

  SearchBloc({required this.userRepositories})
      : assert(userRepositories != null),
        super(SearchInitial()) {
    on<SearchSubmitted>((event, emit) async {
      try {
        search = await userRepositories.searchOrder(event.uuid);
        emit(SearchLoaded(search: search));
      } catch (error) {
        emit(SearchError(error: error.toString()));
      }
    });
    on<ReturnLogin>((event, emit) async {
      emit(SearchInitial());
    });
  }
}
