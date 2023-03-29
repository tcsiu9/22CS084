import 'package:fyp_app/Screen/TaskScreen/task_screen.dart';
import 'package:fyp_app/Screen/screen_export.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('FYP'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            },
            icon: const Icon(FeatherIcons.logOut),
          )
        ],
      ),
      body: const TaskScreen(),
    );
  }
}
