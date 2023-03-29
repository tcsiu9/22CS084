import 'package:flutter/cupertino.dart';
import 'package:fyp_app/Screen/screen_export.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/repositories/user_repositories.dart';

class LoginForm extends StatefulWidget {
  final UserRepositories userRepositories;

  const LoginForm({Key? key, required this.userRepositories})
      : assert(userRepositories != null),
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState(userRepositories);
}

class _LoginFormState extends State<LoginForm> {
  final UserRepositories userRepositories;

  _LoginFormState(this.userRepositories);

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      FocusManager.instance.primaryFocus?.unfocus();
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text));
    }

    _searchOrder() {
      BlocProvider.of<SearchBloc>(context).add(ReturnLogin());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SearchScreen(userRepositories: userRepositories,)));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print(state);
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Login Failed'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child: Form(
            child: Column(
              children: [
                Container(
                  height: 150,
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Logistic System",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      )
                    ],
                  ),
                ),
                TextFormField(
                  style: const TextStyle(fontSize: 14.0, color: Colors.black54),
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  style: const TextStyle(fontSize: 14.0, color: Colors.black54),
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 310.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 45.0,
                        child: state is LoginLoading
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Column(
                                      children: const [
                                        SizedBox(
                                          height: 25.0,
                                          width: 25.0,
                                          child: CupertinoActivityIndicator(),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : ElevatedButton(
                                onPressed: _onLoginButtonPressed,
                                style: ButtonStyle(
                                    backgroundColor:
                                        const MaterialStatePropertyAll<Color>(
                                            Colors.blue),
                                    shape: MaterialStatePropertyAll<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)))),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      SizedBox(
                        height: 45.0,
                        child: ElevatedButton(
                          onPressed: _searchOrder,
                          style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Colors.red),
                              shape: MaterialStatePropertyAll<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))),
                          child: const Text(
                            'Search By Order Id',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
