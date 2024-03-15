import 'package:do_an/constants.dart';
import 'package:do_an/functionHelpers.dart';
import 'package:do_an/modals/User.dart';
import 'package:do_an/redux/actions.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/widgets/EmptyWidget.dart';
import 'package:do_an/ui/widgets/Line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scrollable_tab_view/scrollable_tab_view.dart';
import 'package:redux/redux.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController controller = TabController(
    vsync: this,
    length: ORDER_STATUS.length,
  );
  int _activeIndex = 0;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        _activeIndex = controller.index;
      });
    });
  }

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
                              onPressed: () {},
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
        Container(
          color: Colors.grey[200],
          child: ScrollableTabBar(
            // onTap: (index) => setState(() {
            //   indexPageOrder = index;
            // }),
            labelColor: Colors.black,
            controller: controller,
            isScrollable: true,
            tabs: ORDER_STATUS
                .map((e) => Tab(
                      child: Text(e['label']!),
                    ))
                .toList(),
          ),
        ),
        viewListOrders(
            store.state.orders!, ORDER_STATUS[_activeIndex]['value']!)
      ],
    );
  }
}

Widget buttonChangeInfo(String title, int key) {
  return TextButton(onPressed: () {}, child: const Text("Chỉnh sửa"));
}

Widget viewListOrders(List<dynamic> orders, String type) {
  List<dynamic> dataView = [];
  if (type != '') {
    for (var element in orders) {
      if (element.status! == type) {
        dataView.add(element);
      }
    }
  } else {
    dataView = orders;
  }
  int index = dataView.length;
  return dataView.isEmpty
      ? EmptyWidget("", "no_order.jpg")
      : Column(
          children: dataView.map((e) {
          index = index - 1;
          return Container(
            color: index.isEven ? Colors.blue : Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "ID: ${e.orderCode}",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                "Status: ${e.status}",
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              ...(e.products as List<dynamic>).map((item) => Card(
                    elevation: 2,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: base64ToImageObject(item.productImage!)),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.productName!,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Số lượng: ${item.quantity!}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '\$${formatMoney(double.parse(item.totalPrice))}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phương thức thanh toán : ${e.paymentMethod}",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    "Tổng tiền : ${e.totalPrice}",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ]),
          );
        }).toList());
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
          Expanded(child: buttonChangeInfo("Chỉnh sửa + $title", key))
        ],
      ),
      createLine(Colors.grey, 1, MediaQuery.of(context).size.width),
    ],
  );
}
