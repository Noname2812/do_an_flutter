import 'dart:convert';

import 'package:do_an/api/authApit.dart';
import 'package:do_an/modals/User.dart';
import 'package:do_an/redux/actions.dart';
import 'package:do_an/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

const TYPECHANGE = ['name', 'email', 'phoneNumber', 'address'];

class DialogChangeInfor extends StatefulWidget {
  const DialogChangeInfor({super.key, required this.title, required this.type});
  final String title;
  final int type;
  @override
  State<DialogChangeInfor> createState() => _DialogChangeInforState();
}

class _DialogChangeInforState extends State<DialogChangeInfor> {
  String message = "";
  final formKey = GlobalKey<FormState>();
  TextEditingController fieldController = TextEditingController();
  @override
  void dispose() {
    fieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    Future<bool> callApiChange(Map<String, String> map, BuildContext c) async {
      final res = await changeInfo(map, store.state.user.id!, 2);
      if (res.statusCode == 200) {
        return true;
      } else {
        message = jsonDecode(res.body)['message'];
      }
      return false;
    }

    void handleChange(BuildContext c) async {
      Map<String, String> param = {};
      bool check = false;
      switch (widget.type) {
        case 0:
          {
            param = ParamChangeInfo(name: fieldController.text).toMapName();
            check = await callApiChange(param, c);
            if (check) {
              User user = store.state.user;
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              store.dispatch(
                  ChangeInfo(user: user.copyWith(name: fieldController.text)));
            }
            break;
          }
        case 1:
          {
            param = ParamChangeInfo(email: fieldController.text).toMapEmail();
            check = await callApiChange(param, c);
            if (check) {
              User user = store.state.user;
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              store.dispatch(
                  ChangeInfo(user: user.copyWith(email: fieldController.text)));
            }
            break;
          }
        case 2:
          {
            param =
                ParamChangeInfo(phoneNumber: fieldController.text).toMapPhone();
            check = await callApiChange(param, c);
            if (check) {
              User user = store.state.user;
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              store.dispatch(ChangeInfo(
                  user: user.copyWith(phoneNumber: fieldController.text)));
            }
            break;
          }
        case 3:
          {
            param =
                ParamChangeInfo(address: fieldController.text).toMapAddress();
            check = await callApiChange(param, c);
            if (check) {
              User user = store.state.user;
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              store.dispatch(ChangeInfo(
                  user: user.copyWith(address: fieldController.text)));
            }
            break;
          }
      }
      final res = await changeInfo(
          ParamChangeInfo().toMapAddress(), store.state.user.id!, 2);
      if (res.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.pop(c);
      } else {
        message = jsonDecode(res.body)['message'];
      }
    }

    return AlertDialog(
      title: Text("Thay đổi ${widget.title} "),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 8,
        child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration:
                      InputDecoration(label: Text("${widget.title} mới:")),
                  controller: fieldController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Vui lòng điền ${widget.title}";
                    }
                    return null;
                  },
                ),
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
            child: const Text("Change"))
      ],
    );
  }
}
