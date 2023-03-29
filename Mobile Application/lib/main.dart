import 'package:flutter/material.dart';
import 'package:fyp_app/Bloc/OrderBloc/order_bloc.dart';
import 'package:fyp_app/Bloc/SearchBloc/search_bloc.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/Screen/HomeScreen/home_screen.dart';
import 'package:fyp_app/Screen/LoginScreen/login_screen.dart';
import 'package:fyp_app/repositories/geolocation_repositories.dart';
import 'package:fyp_app/repositories/user_repositories.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  final UserRepositories userRepositories = UserRepositories();

  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocationRepositories>(
          create: (context) => GeolocationRepositories(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return AuthBloc(userRepositories: userRepositories)
                ..add(AppStarted());
            },
          ),
          BlocProvider(
            create: (context) => RouteBloc(userRepositories: userRepositories),
          ),
          BlocProvider(
            create: (context) => TaskBloc(userRepositories: userRepositories),
          ),
          BlocProvider(create: (context) => TaskStatusBloc(userRepositories: userRepositories)),
          BlocProvider(create: (context) {
            return GeolocationBloc(
                geolocationRepositories:
                    context.read<GeolocationRepositories>())
              ..add(LoadGeolocation());
          }),
          BlocProvider(create: (context) => SearchBloc(userRepositories: userRepositories)),
          BlocProvider(create: (context) => OrderBloc(userRepositories: userRepositories)),
        ],
        child: MyApp(userRepositories: userRepositories),
      )));
}

class MyApp extends StatelessWidget {
  final UserRepositories userRepositories;

  MyApp({Key? key, required this.userRepositories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        if (state is AuthAuthenticated) {
          return const HomeScreen();
        }
        if (state is AuthUnauthenticated) {
          return LoginScreen(userRepositories: userRepositories);
        }
        if (state is AuthLoading) {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }),
    );
  }
}
