import 'package:do_an/functionHelpers.dart';
import 'package:do_an/redux/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class DetailOrder extends StatelessWidget {
  const DetailOrder({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final dataOrder = store.state.orders?.firstWhere((item) => item.id == id);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Chi tiết hóa đơn",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    "Danh sách sản phẩm",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...(dataOrder.products as List<dynamic>).map((item) => Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
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
                                    image: base64ToImageObject(
                                        item.productImage!)),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                  const Text(
                    "Thông tin người nhận hàng",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Người nhận: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(dataOrder.customerName,
                              style: const TextStyle(fontSize: 18))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Số điện thoại: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(dataOrder.customerPhone,
                              style: const TextStyle(fontSize: 18))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Email liên hệ: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(dataOrder.customerEmail,
                              style: const TextStyle(fontSize: 18))
                        ],
                      )
                    ],
                  ),
                  const Text(
                    "Thông tin thanh toán",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tổng tiền sản phẩm: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            dataOrder.totalProductPrice,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Số tiền giảm: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            dataOrder.voucherDiscount,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Phí vận chuyển: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            dataOrder.deliveryFee,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Phương thức thanh toán: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            dataOrder.paymentMethod,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Tổng tiền phải trả: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            dataOrder.totalPrice,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Trạng thái: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            dataOrder.status,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Thời gian tạo đơn: ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            convertDateTime(dataOrder.createdAt),
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
