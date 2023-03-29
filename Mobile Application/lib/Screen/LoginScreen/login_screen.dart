import 'package:fyp_app/Screen/screen_export.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/repositories/user_repositories.dart';

class LoginScreen extends StatelessWidget {
  final UserRepositories userRepositories;

  LoginScreen({Key? key, required this.userRepositories})
      : assert(userRepositories != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              userRepositories: userRepositories,
              authBloc: BlocProvider.of<AuthBloc>(context));
        },
        child: LoginForm(userRepositories: userRepositories),
      ),
    );
  }
}
