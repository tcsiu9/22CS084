import 'package:flutter/material.dart';
import 'package:fyp_app/Screen/screen_export.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchOrderController = TextEditingController();

    _onSearchPressed() {
      FocusManager.instance.primaryFocus?.unfocus();
      BlocProvider.of<SearchBloc>(context)
          .add(SearchSubmitted(uuid: _searchOrderController.text));
    }

    _login() {
      Navigator.of(context).pop();
    }

    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Padding(
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
                      "Search Order Status",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 75.0,
              ),
              TextFormField(
                style: const TextStyle(fontSize: 14.0, color: Colors.black54),
                controller: _searchOrderController,
                decoration: const InputDecoration(
                  hintText: 'Order ID',
                ),
              ),
              const SizedBox(
                height: 300.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 45.0,
                      child: ElevatedButton(
                        onPressed: _onSearchPressed,
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
                          'Search Order',
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
                        onPressed: _login,
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
                          'Go to Login Page',
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
      ),
    );
  }
}
