import 'package:do_an/api/cartApi.dart';
import 'package:do_an/api/giaoHangNhanhApi.dart';
import 'package:do_an/api/requestGet.dart';
import 'package:do_an/functionHelpers.dart';
import 'package:do_an/modals/Cart.dart';
import 'package:do_an/modals/Order.dart';
import 'package:do_an/modals/PlaceModals.dart';
import 'package:do_an/modals/Voucher.dart';
import 'package:do_an/redux/actions.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/widgets/DropdownWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
  int deliveryFee = 0;
  String? provinceID, districtID;
  Map<String, String> voucher = {"name": "", "voucherCode": ""};
  @override
  void dispose() {
    addressController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    provinceID = "";
    districtID = "";
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
    double totalPrice = widget.type == 1
        ? caculatorCart(store.state.cart).toDouble()
        : widget.item!.totalPrice!.toDouble();
    void getFeeDelivery(String value) async {
      final res = await getFee(ParamGetFee(
          insurance_value: widget.type == 1
              ? caculatorCart(store.state.cart).toString()
              : widget.item!.totalPrice.toString(),
          to_district_id: districtID!,
          to_ward_code: value));
      setState(() {
        deliveryFee = res["total"];
      });
    }

    void handlePayment(String paymentMethod, String? paid) async {
      ParamPayment p = ParamPayment(
          totalPaid: paymentMethod == "cash" ? "0" : paid,
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
          deliveryFee: deliveryFee.toString(),
          paymentMethod: paymentMethod,
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

    void handleSelectProvince(String value) {
      setState(() {
        provinceID = value;
      });
    }

    void handleSelectDistrict(String value) {
      setState(() {
        districtID = value;
      });
    }

    void handleSelectWard(String value) {
      getFeeDelivery(value);
    }

    void onPaymentWithVNP(double totalPrice, String title) async {
      final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
        url: 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html',
        version: '2.0.0',
        tmnCode: '0HU69EBU',
        txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
        orderInfo: title,
        amount: totalPrice,
        returnUrl: "http://localhost:8000",
        ipAdress: "192.168.0.107",
        vnpayHashKey: 'VEXPZRANPKSPPPFTGBPBNIZHIDOCFNQA',
      );
      print({"paymentUrl": paymentUrl});
      VNPAYFlutter.instance.show(
        paymentUrl: paymentUrl,
        onPaymentSuccess: (params) {
          handlePayment("vnpay", (params["vnp_TmnCode"] / 100).toString());
        },
        onPaymentError: (params) {},
      );
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
                      DropdownWidget(
                        type: 0,
                        function: handleSelectProvince,
                      ),
                      DropdownWidget(
                        type: 1,
                        function: handleSelectDistrict,
                        provinceID: provinceID,
                      ),
                      DropdownWidget(
                        type: 2,
                        function: handleSelectWard,
                        districtID: districtID,
                      ),
                      TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(
                            labelText: "Địa chỉ chi tiết nhận hàng"),
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
                                  "Tiền tổng sản phẩm: ${formatMoney(totalPrice)} đ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Phí giao hàng: ${formatMoney(deliveryFee.toDouble())} đ",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Số tiền giảm: ${formatMoney(discountValue)}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Tổng tiền phải trả:${formatMoney(totalPrice - discountValue + deliveryFee.toDouble())}đ",
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
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              bool? isValid = _formKey.currentState?.validate();
                              if (isValid!) {
                                store.dispatch(StateLoading(isLoading: true));
                                handlePayment("cash", null);
                              }
                            },
                            child: const Text('Submit'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              bool? isValid = _formKey.currentState?.validate();
                              if (isValid!) {
                                onPaymentWithVNP(
                                    totalPrice -
                                        discountValue +
                                        deliveryFee.toDouble(),
                                    "Thanh toán hóa đơn giá ${totalPrice - discountValue + deliveryFee.toDouble()}");
                              }
                            },
                            child: const Text('Payment with VNP'),
                          ),
                        ],
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
