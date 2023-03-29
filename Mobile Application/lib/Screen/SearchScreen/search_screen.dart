import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/Screen/SearchScreen/search_info.dart';
import 'package:fyp_app/Screen/screen_export.dart';
import 'package:fyp_app/repositories/user_repositories.dart';

class SearchScreen extends StatefulWidget {
  final UserRepositories userRepositories;

  const SearchScreen({Key? key, required this.userRepositories})
      : assert(userRepositories != null),
        super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState(userRepositories);
}

class _SearchScreenState extends State<SearchScreen> {
  final UserRepositories userRepositories;

  _SearchScreenState(this.userRepositories);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchError) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong Order Id'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          // if (state is SearchInitial) {
          //
          // }
          if (state is SearchLoaded) {
            return SearchInfo(state: state);
          }
          return const SearchForm();

        },
      ),
    );
  }
}
