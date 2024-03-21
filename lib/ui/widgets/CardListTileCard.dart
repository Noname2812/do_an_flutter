import 'dart:async';

import 'package:do_an/api/cartApi.dart';
import 'package:do_an/functionHelpers.dart';
import 'package:do_an/modals/Cart.dart';
import 'package:do_an/redux/actions.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/widgets/CustomSteper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CartListTileCard extends StatefulWidget {
  final ItemCart cartData;

  const CartListTileCard({
    super.key,
    required this.cartData,
  });

  @override
  State<CartListTileCard> createState() => _CartListTileCardState();
}

class _CartListTileCardState extends State<CartListTileCard> {
  Timer? _updateTimer;
  @override
  Widget build(BuildContext context) {
    final userID = StoreProvider.of<AppState>(context).state.user.id;
    final store = StoreProvider.of<AppState>(context);
    void handleDelete() async {
      store.dispatch(StateLoading(isLoading: true));
      final res = await deleteItemCart(widget.cartData.id!);
      if (res.statusCode == 200) {
        List<ItemCart> cart = await getCartByUser(userID!);
        store.dispatch(GetCartSuccess(cart: cart));
      } else {
        store.dispatch(StateLoading(isLoading: false));
        showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  content: const Text("Có lỗi xảy ra trong quá trình xóa !"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"))
                  ],
                ));
      }
    }

    void handleUpdate(int value) async {
      if (_updateTimer != null) {
        _updateTimer!.cancel();
        _updateTimer = null;
      }
      _updateTimer ??= Timer(const Duration(seconds: 1), () async {
        // update cart
        store.dispatch(StateLoading(isLoading: true));
        final res = await editCart(widget.cartData.id!, value.toString());
        if (res.statusCode == 200) {
          List<ItemCart> cart = await getCartByUser(userID!);
          store.dispatch(GetCartSuccess(cart: cart));
        }
        _updateTimer = null;
      });
    }

    return Stack(
      children: [
        Positioned(
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: base64ToImageObject(
                            widget.cartData.product!.images[0])),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.cartData.product!.name,
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: widget
                                        .cartData.product!.groupOptions!
                                        .map((item) {
                                      String index =
                                          "option${widget.cartData.product!.groupOptions!.indexOf(item) + 1}";
                                      return Text(
                                          '${item["groupName"]}: ${widget.cartData.productSKU[index]}');
                                    }).toList(),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${formatMoney(widget.cartData.totalPrice!.toDouble())}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 85,
                              child: FittedBox(
                                child: CustomStepper(
                                  lowerLimit: 1,
                                  upperLimit: 99,
                                  stepValue: 1,
                                  value: widget.cartData.quantity!,
                                  onChanged: (int value) {
                                    handleUpdate(value);
                                  },
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: 10,
            right: 20,
            child: InkWell(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          content: const Text("Are you sure delete ?"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("NO")),
                            TextButton(
                                onPressed: () {
                                  handleDelete();
                                  Navigator.pop(context);
                                },
                                child: const Text("OK")),
                          ],
                        ));
              },
              child: const SizedBox(
                width: 20,
                height: 20,
                child: Icon(Icons.delete),
              ),
            )),
      ],
    );
  }
}
