import 'package:do_an/constants.dart';
import 'package:do_an/functionHelpers.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/screen/profile/DetailOrder.dart';
import 'package:do_an/ui/widgets/EmptyWidget.dart';
import 'package:do_an/ui/widgets/SlidePageRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scrollable_tab_view/scrollable_tab_view.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({
    super.key,
  });

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders>
    with SingleTickerProviderStateMixin {
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
        ScrollableTabBar(
          labelColor: Colors.black,
          controller: controller,
          isScrollable: true,
          tabs: ORDER_STATUS
              .map((e) => Tab(
                    child: Text(e['label']!),
                  ))
              .toList(),
        ),
        viewListOrders(
            store.state.orders!, ORDER_STATUS[_activeIndex]['value']!, context)
      ],
    );
  }
}

Widget viewListOrders(List<dynamic> orders, String type, BuildContext context) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status: ${e.status}",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context, SlidePageRoute(page: DetailOrder(id: e.id))),
                    child: const Text(
                      "Xem chi tiết",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        decorationThickness: 2,
                      ),
                    ),
                  )
                ],
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
