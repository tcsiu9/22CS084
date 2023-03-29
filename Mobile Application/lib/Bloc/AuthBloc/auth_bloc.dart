import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fyp_app/repositories/user_repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepositories userRepositories;

  AuthBloc({required this.userRepositories})
      : assert(userRepositories != null),
        super(AuthUninitialized()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepositories.hasToken();
      if (hasToken) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });
    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      await userRepositories.persistentToken(event.token);
      emit(AuthAuthenticated());
    });
    on<LoggedOut>((event, emit) async {
      emit(AuthLoading());
      await userRepositories.deleteToken();
      emit(AuthUnauthenticated());
    });
  }

// FutureOr<void> _checkToken(AppStarted event, Emitter<AuthState> emit) async*{
//   final bool hasToken = await loginRepositories.hasToken();
//   print(event.toString());
//   if(hasToken){
//     emit(AuthAuthenticated());
//   }else{
//     emit(AuthUnauthenticated());
//   }
// }
//
// FutureOr<void> _loggedIn(LoggedIn event, Emitter<AuthState> emit) async*{
//   emit(AuthLoading());
//   await loginRepositories.persisteToken(event.token);
//   emit(AuthAuthenticated());
// }
//
// FutureOr<void> _logout(LoggedOut event, Emitter<AuthState> emit) async*{
//   emit(AuthLoading());
//   await loginRepositories.deleteToken();
//   emit(AuthUnauthenticated());
// }
}
