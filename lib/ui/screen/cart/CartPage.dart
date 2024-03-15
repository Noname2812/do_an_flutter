import 'package:do_an/functionHelpers.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/widgets/ButtonNavBar.dart';
import 'package:do_an/ui/widgets/CardListTileCard.dart';
import 'package:do_an/ui/widgets/Checkout.dart';
import 'package:do_an/ui/widgets/EmptyWidget.dart';
import 'package:do_an/ui/widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cart",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      body: StoreConnector<AppState, GetState>(
          converter: (Store<AppState> store) => GetState.fromStore(store),
          builder: (BuildContext context, GetState vm) {
            return vm.cart.isEmpty
                ? EmptyWidget("", "empty_cart.png")
                : Stack(children: [
                    vm.isLoading
                        ? const Positioned(child: Loading(isFullScreen: true))
                        : Column(
                            children: [
                              Expanded(
                                flex: 11,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: vm.cart.length,
                                  itemBuilder: (context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: CartListTileCard(
                                        cartData: vm.cart[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                clipBehavior: Clip.hardEdge,
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(24),
                                    topLeft: Radius.circular(24),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Total Price",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "\$ ${formatMoney(caculatorCart(vm.cart))}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CheckoutPage())),
                                          child: const Text(
                                            "Check Out",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ]);
          }),
      bottomNavigationBar: CustomButtonsNavigationBar(current: 2),
    );
  }
}
