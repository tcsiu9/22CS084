import 'package:equatable/equatable.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/repositories/user_repositories.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepositories userRepositories;
  final AuthBloc authBloc;

  LoginBloc({required this.userRepositories, required this.authBloc})
      : assert(userRepositories != null),
        assert(authBloc != null),
        super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final token =
            await userRepositories.login(event.username, event.password);
        authBloc.add(LoggedIn(token: token));
        emit(LoginInitial());
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });
  }

// FutureOr<void> _login(LoginButtonPressed event, Emitter<LoginState> emit) async*{
//   emit(LoginLoading());
//   try{
//     final token = await loginRepositories.login(event.username, event.password);
//     authBloc.add(LoggedIn(token: token));
//     emit(LoginInitial());
//   }catch(error){
//     emit(LoginFailure(error: error.toString()));
//   }
// }
}
