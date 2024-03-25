import 'package:do_an/api/cartApi.dart';
import 'package:do_an/functionHelpers.dart';
import 'package:do_an/modals/Cart.dart';
import 'package:do_an/modals/Order.dart';
import 'package:do_an/modals/Voucher.dart';
import 'package:do_an/redux/actions.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/widgets/DropdownWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, this.item, required this.type});
  final ItemCart? item;
  final int type;
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  double discountValue = 0;
  Map<String, String> voucher = {"name": "", "voucherCode": ""};
  @override
  void dispose() {
    addressController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void handleChoiceVoucher(Voucher vc, double total) {
    double discount = total * vc.value! / 100;
    setState(() {
      if (discount > vc.maxDiscountValue!) {
        discountValue = vc.maxDiscountValue!.toDouble();
      } else {
        discountValue = discount;
      }
      voucher['name'] = "Bạn đã chọn ${vc.name!}";
      voucher["voucherCode"] = vc.code!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    nameController.text = store.state.user.name ?? '';
    addressController.text = store.state.user.address ?? '';
    phoneController.text = store.state.user.phoneNumber ?? '';
    emailController.text = store.state.user.email ?? '';
    String totalPrice = widget.type == 1
        ? formatMoney(
            caculatorCart(store.state.cart).toDouble() - discountValue)
        : formatMoney(widget.item!.totalPrice!.toDouble() - discountValue);
    void handlePayment() async {
      ParamPayment p = ParamPayment(
          voucherCode: voucher["voucherCode"],
          discountValue: discountValue.toString(),
          userID: store.state.user.id!,
          products: widget.type == 1 ? store.state.cart : [widget.item!],
          totalProductPrice: widget.type == 1
              ? caculatorCart(store.state.cart).toString()
              : widget.item!.totalPrice.toString(),
          customerName: nameController.text,
          customerPhone: phoneController.text,
          customerEmail: emailController.text,
          deliveryFee: '0',
          paymentMethod: "cash",
          deliveryAddress: "deliveryAddress");
      final res = await payment(p);
      if (res.statusCode == 200) {
        store.dispatch(GetCartSuccess(cart: List.empty()));
        List<dynamic> orders = await getOrderByUser(store.state.user.id!);
        store.dispatch(GetOrderSuccess(orders: orders as List<Order>));
        showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  content: const Text(
                    "Bạn đã thanh toán thành công !",
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pushNamed(context, "/"),
                        child: const Text("OK"))
                  ],
                )).then((value) => Navigator.pushNamed(context, "/"));
      }
    }

    void handleOpenListVoucher(BuildContext context) async {
      final res = await getVoucher();
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
                contentPadding: const EdgeInsets.all(2),
                title: const Text("Chọn voucher"),
                content: res.isEmpty
                    ? const Text("Không có voucher nào")
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: res
                                .map((e) => InkWell(
                                      onTap: () {
                                        double total = widget.type == 1
                                            ? caculatorCart(store.state.cart)
                                                .toDouble()
                                            : widget.item!.totalPrice!
                                                .toDouble();
                                        handleChoiceVoucher(e, total);
                                        Navigator.pop(context);
                                      },
                                      child: Card(
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                child: Text(e.name!),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                child: Text(
                                                    "Đơn hàng phải từ ${formatMoney(e.minOrderValue!.toDouble())} trở lên."),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 10,
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                child: Text(
                                                    "Giảm tối đa: ${formatMoney(e.maxDiscountValue!.toDouble())}"),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Đóng"))
                ],
              ));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Checkout",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Thông tin nhận hàng",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Tên khách hàng",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(
                            labelText: "Địa chỉ nhận hàng"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration: const InputDecoration(labelText: "SĐT"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: "EMail"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  onPressed: () =>
                                      handleOpenListVoucher(context),
                                  child: const Text(
                                    "Chọn voucher",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Tổng tiền đơn hàng: $totalPrice đ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  voucher["name"] ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const DropdownWidget(),
                      ElevatedButton(
                        onPressed: () {
                          bool? isValid = _formKey.currentState?.validate();
                          if (isValid!) {
                            store.dispatch(StateLoading(isLoading: true));
                            handlePayment();
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
