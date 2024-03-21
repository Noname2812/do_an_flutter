import 'package:do_an/functionHelpers.dart';
import 'package:do_an/modals/User.dart';
import 'package:do_an/redux/actions.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/widgets/DialogChangeInfo.dart';
import 'package:do_an/ui/widgets/DialogChangePassword.dart';
import 'package:do_an/ui/widgets/Line.dart';
import 'package:do_an/ui/widgets/MyOrders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: base64ToImageObject(widget.user.image!),
                            fit: BoxFit.fill)),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          widget.user.name!,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 5),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const DialogChangePassword();
                                    });
                              },
                              child: const Text(
                                "Đổi mật khẩu",
                                style: TextStyle(color: Colors.white),
                              )),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 5),
                            ),
                            onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      content: const Text(
                                        "Are you sure logout ?",
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("No")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              store.dispatch(
                                                  Logout(isLogout: true));
                                            },
                                            child: const Text("Yes")),
                                      ],
                                    )),
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const Text(
          "Thông tin cá nhân",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        lineInfor("Tên", 0, widget.user.name, context),
        lineInfor("Email", 1, widget.user.email, context),
        lineInfor("SĐT", 2, widget.user.phoneNumber, context),
        lineInfor("Địa chỉ", 3, widget.user.address, context),
        const Text(
          "Lịch sử mua hàng",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Container(color: Colors.grey[200], child: const MyOrders()),
      ],
    );
  }
}

Widget lineInfor(String title, int key, String? text, BuildContext context) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(title),
          )),
          Expanded(
            flex: 2,
            child: Text(text ?? ""),
          ),
          Expanded(
              child: TextButton(
                  onPressed: () {
                    if (key == 1) {
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DialogChangeInfor(
                            title: TYPECHANGE[key],
                            type: key,
                          );
                        });
                  },
                  child: Text(key == 1 ? "" : "Chỉnh sửa")))
        ],
      ),
      createLine(Colors.grey, 1, MediaQuery.of(context).size.width),
    ],
  );
}
