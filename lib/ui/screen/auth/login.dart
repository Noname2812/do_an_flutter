// ignore_for_file: library_private_types_in_public_api
import 'package:do_an/api/authApit.dart';
import 'package:do_an/modals/User.dart';
import 'package:do_an/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  String message = "";
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GetState>(
        converter: (Store<AppState> store) => GetState.fromStore(store),
        builder: (BuildContext context, GetState vm) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Username cannot be empty' : null,
                    onChanged: (value) => username = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Password cannot be empty' : null,
                    onChanged: (value) => password = value,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        vm.setLoading(true);
                        final result = await login(username, password, "login");
                        if (result["message"] == null) {
                          vm.login(User.fromJson(result));
                        } else {
                          vm.setLoading(false);
                          message = result["message"];
                          print({"object": message});
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        message,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
          );
        });
  }
}
