import 'package:flutter/material.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/Screen/screen_export.dart';

class SearchInfo extends StatefulWidget {
  final SearchLoaded state;

  const SearchInfo({Key? key, required this.state})
      : assert(state != null),
        super(key: key);

  @override
  State<SearchInfo> createState() => _SearchInfoState(state);
}

class _SearchInfoState extends State<SearchInfo> {
  final SearchLoaded state;

  _SearchInfoState(this.state);

  _returnLoginPage() {
    BlocProvider.of<SearchBloc>(context).add(ReturnLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 150,
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Order Status",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  SearchStatusList(
                    statusList: state.search,
                  ),
                  SizedBox(
                    height: 45.0,
                    child: ElevatedButton(
                      onPressed: _returnLoginPage,
                      style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(Colors.red),
                          shape:
                              MaterialStatePropertyAll<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)))),
                      child: const Text(
                        'Back to Search Screen',
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
        ));
  }
}
