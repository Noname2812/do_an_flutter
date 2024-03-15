import 'package:collection/collection.dart';
import 'package:do_an/api/cartApi.dart';
import 'package:do_an/functionHelpers.dart';
import 'package:do_an/modals/Cart.dart';
import 'package:do_an/modals/Product.dart';
import 'package:do_an/redux/actions.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/widgets/Checkout.dart';
import 'package:do_an/ui/widgets/CustomSteper.dart';
import 'package:do_an/ui/widgets/Line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ModalBottomSheetOpen extends StatefulWidget {
  const ModalBottomSheetOpen(
      {super.key,
      this.userID,
      required this.product,
      required this.nameButton,
      required this.type});
  final String nameButton;
  final int type;
  final DetailProduct product;
  final String? userID;
  @override
  State<ModalBottomSheetOpen> createState() => _ModalBottomSheetOpenState();
}

class _ModalBottomSheetOpenState extends State<ModalBottomSheetOpen> {
  int quantity = 1;
  Set<Map<String, String>> productSKU = {};
  String price = "0";
  String barcode = "";
  List<Widget> showAllOptions(List<dynamic> data, String groupName) {
    final List<dynamic> chunks = data.slices(4).toList();
    return chunks
        .map((item) => Row(
              children: (item as List<dynamic>)
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(3),
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    keyExists(productSKU, groupName,
                                                e as String) !=
                                            null
                                        ? Colors.grey[300]
                                        : Colors.blue[200])),
                            onPressed: () {
                              setState(() {
                                bool flag = false;
                                for (final element in productSKU) {
                                  if (element.containsKey(groupName)) {
                                    element[groupName] = e;
                                    flag = true;
                                    break;
                                  }
                                }
                                if (!flag) {
                                  productSKU.add({groupName: e});
                                }
                                onChangeBarcode();
                              });
                            },
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 12),
                            )),
                      ))
                  .toList(),
            ))
        .toList();
  }

  void onChangeBarcode() {
    if (productSKU.toList().length == 2) {
      String option1 = getValueByKey(
          productSKU, widget.product.groupOptions![0]["groupName"]);
      String option2 = getValueByKey(
          productSKU, widget.product.groupOptions![1]["groupName"]);
      Map<String, String> typeProduct =
          getBarcode(widget.product.productSKUList!, option1, option2);
      price = (int.parse(typeProduct["price"]!) * quantity).toString();
      barcode = typeProduct["barcode"]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userID = StoreProvider.of<AppState>(context).state.user.id;
    final store = StoreProvider.of<AppState>(context);

    void handleAddToCart() async {
      if (productSKU.toList().length != 2) {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('OK'),
                    ),
                  ],
                  content: const Text(
                    textAlign: TextAlign.center,
                    "Vui lòng chọn đầy đủ các option !",
                    style: TextStyle(fontSize: 18),
                  ),
                ));
      } else {
        store.dispatch(StateLoading(isLoading: true));
        final res = await addToCart(
            ParamAddToCart(
                barcode: barcode,
                quantity: quantity.toString(),
                price: price,
                productId: widget.product.id),
            userID!);

        if (res.statusCode == 200) {
          List<ItemCart> cart = await getCartByUser(userID);
          store.dispatch(GetCartSuccess(cart: cart));
          showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: const Text("Thêm sản phẩm thành công !"),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"))
                    ],
                  ));
        }
      }
    }

    return Stack(children: [
      Positioned(
          top: 2,
          right: 16,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "X",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
          )),
      Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image(
                      image: base64ToImageObject(widget.product.images[0]),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LayoutBuilder(
                              builder: (context, contraint) => SizedBox(
                                    width: contraint.maxWidth * 0.9,
                                    child: Text(
                                      maxLines: 3,
                                      widget.product.name,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  )),
                          Row(
                            children: [
                              SizedBox(
                                  child: Text(
                                formatMoney(widget.product.minprice.toDouble()),
                                textAlign: TextAlign.start,
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 15),
                              )),
                              const SizedBox(
                                  child: Text(
                                " - ",
                                textAlign: TextAlign.start,
                                textDirection: TextDirection.ltr,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 15),
                              )),
                              SizedBox(
                                  child: Text(
                                "${formatMoney(widget.product.maxPrice.toDouble())} vnd",
                                textAlign: TextAlign.start,
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                    overflow: TextOverflow.fade,
                                    color: Colors.red,
                                    fontSize: 15),
                              )),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          createLine(Colors.grey, 1, MediaQuery.of(context).size.width),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ...widget.product.groupOptions!.map((e) => Column(
                        children: [
                          Text(
                            e['groupName'],
                            style: const TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            child: Column(
                              children: showAllOptions(
                                  e['options'] as List<dynamic>,
                                  e['groupName']),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Thành tiền: ${formatMoney(double.parse(price))}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Số lượng: ",
                          style: TextStyle(fontSize: 15),
                        ),
                        FittedBox(
                          child: CustomStepper(
                            lowerLimit: 1,
                            upperLimit: 99,
                            stepValue: 1,
                            value: quantity,
                            onChanged: (int value) {
                              setState(() {
                                quantity = value;
                                onChangeBarcode();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                  onPressed: widget.type == 1
                      ? () => handleAddToCart()
                      : () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                    item: ItemCart(
                                        quantity: quantity,
                                        product: widget.product,
                                        price: int.parse(price)),
                                  ))),
                  child: Text(
                    widget.nameButton,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ))
        ],
      ),
    ]);
  }
}
