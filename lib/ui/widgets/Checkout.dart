import 'package:do_an/api/cartApi.dart';
import 'package:do_an/functionHelpers.dart';
import 'package:do_an/modals/Cart.dart';
import 'package:do_an/modals/Order.dart';
import 'package:do_an/redux/actions.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/widgets/Loading.dart';
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
  @override
  void dispose() {
    addressController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print({"item": widget.item});
    final store = StoreProvider.of<AppState>(context);
    nameController.text = store.state.user.name ?? '';
    addressController.text = store.state.user.address ?? '';
    phoneController.text = store.state.user.phoneNumber ?? '';
    emailController.text = store.state.user.email ?? '';
    void handlePayment() async {
      ParamPayment p = ParamPayment(
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Checkout",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
      body: store.state.isLoading
          ? const Loading(isFullScreen: true)
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                              decoration:
                                  const InputDecoration(labelText: "SĐT"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a value';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration:
                                  const InputDecoration(labelText: "EMail"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a value';
                                }
                                return null;
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                bool? isValid =
                                    _formKey.currentState?.validate();
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
