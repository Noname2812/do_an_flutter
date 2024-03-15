import 'dart:convert';

import 'package:do_an/api/authApit.dart';
import 'package:do_an/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DialogChangePassword extends StatefulWidget {
  const DialogChangePassword({super.key});

  @override
  State<DialogChangePassword> createState() => _DialogChangePasswordState();
}

class _DialogChangePasswordState extends State<DialogChangePassword> {
  String message = "";
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  @override
  void dispose() {
    newPasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    void handleChange(BuildContext c) async {
      final res = await changeInfo(
          ParamChangeInfo(
                  password: passwordController.text,
                  newPassword: newPasswordController.text)
              .toMapPassword(),
          store.state.user.id!,
          1);
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.pop(c);
      } else {
        message = jsonDecode(res.body)['message'];
      }
    }

    return AlertDialog(
      title: const Text("Thay đổi mật khẩu "),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 5,
        child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration:
                      const InputDecoration(label: Text("Mật khẩu hiện tại:")),
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Mật khẩu không được ít hơn 6 kí tự !";
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: newPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration:
                        const InputDecoration(label: Text("Mật khẩu mới:")),
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Mật khẩu không được ít hơn 6 kí tự !";
                      }
                      return null;
                    }),
                Text(
                  message,
                  style: const TextStyle(color: Colors.red),
                )
              ],
            )),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              bool? isValid = formKey.currentState?.validate();
              if (isValid!) {
                handleChange(context);
              }
            },
            child: const Text("Change password"))
      ],
    );
  }
}
