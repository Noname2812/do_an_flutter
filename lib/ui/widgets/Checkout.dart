import 'package:do_an/api/cartApi.dart';
import 'package:do_an/modals/Cart.dart';
import 'package:do_an/redux/actions.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key, this.item});
  final ItemCart? item;
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
    final store = StoreProvider.of<AppState>(context);

    void handlePayment() async {
      store.dispatch(StateLoading(isLoading: true));
      ParamPayment p = ParamPayment(
          userID: store.state.user.id!,
          products: widget.item != null
              ? List.filled(1, widget.item!)
              : store.state.cart,
          customerName: nameController.text,
          customerPhone: phoneController.text,
          customerEmail: emailController.text,
          paymentMethod: "cash",
          deliveryAddress: "deliveryAddress");
      final res = await payment(p);
      if (res.statusCode == 200) {
        store.dispatch(GetCartSuccess(cart: List.empty()));
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
                ));
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
                        child: Column(
                      children: [
                        const Text(
                          "Vui lòng nhập thông tin nhận hàng",
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
                        ElevatedButton(
                          onPressed: () => handlePayment(),
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
