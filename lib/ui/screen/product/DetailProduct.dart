// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/widgets/ModalBottomSheetOpen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:do_an/api/productApi.dart';
import 'package:do_an/constants.dart';
import 'package:do_an/functionHelpers.dart';
import 'package:do_an/modals/Product.dart';
import 'package:do_an/ui/widgets/CarouselSlider.dart';
import 'package:do_an/ui/widgets/Loading.dart';

Future handleOntapBottomButton(
    BuildContext context, DetailProduct product, int type) {
  return showModalBottomSheet(
      backgroundColor: Colors.grey[50],
      context: context,
      builder: (context) {
        return ModalBottomSheetOpen(
          product: product,
          nameButton: type == 2 ? "Mua ngay" : "Add to cart",
          type: type,
        );
      });
}

class DetailProductPage extends StatefulWidget {
  const DetailProductPage({super.key, required this.id});
  final String id;

  @override
  State<DetailProductPage> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProductPage> {
  DetailProduct product = DetailProduct.constructor();
  bool isLoading = true;
  void getDataDetailProducts(String id) async {
    final res = await getDetailProduct(id);
    setState(() {
      product = DetailProduct.fromJson(res["product"]);
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataDetailProducts(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final userID = StoreProvider.of<AppState>(context).state.user.id;
    return isLoading
        ? const Loading(
            isFullScreen: true,
          )
        : Scaffold(
            bottomNavigationBar: Row(
              children: itemsBottomNavigationBavDetailProduct
                  .map((e) => Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: InkWell(
                          onTap: () {
                            if (userID == null) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text(
                                            "Are you going to login now ?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("No")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                    context, "/user");
                                              },
                                              child: const Text("Yes")),
                                        ],
                                      ));
                            } else {
                              e.type == 1
                                  ? {
                                      {
                                        handleOntapBottomButton(
                                            context, product, 1)
                                      }
                                    }
                                  : handleOntapBottomButton(
                                      context, product, 2);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            height: 50,
                            color: e.bgColor,
                            child: Column(
                              children: [
                                e.icon,
                                Text(
                                  e.title,
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      )))
                  .toList(),
            ),
            appBar: AppBar(
              actions: [
                Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[50]),
                  child: IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, "/cart")),
                )
              ],
            ),
            body: SafeArea(child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          // images
                          Carousel(
                            list: product.images,
                            isAutoPlay: false,
                            bgColor: Colors.grey[100],
                            height: 300,
                            type: 2,
                          ),
                          // price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Giá chỉ từ ",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                              Text(
                                formatMoney(product.minprice.toDouble()),
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 16),
                              ),
                              const Text(
                                " đến ",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              ),
                              Text(
                                "${formatMoney(product.maxPrice.toDouble())} VNĐ",
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 16),
                              )
                            ],
                          ),
                          // name product
                          Text(
                            product.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          // description
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Mô tả sản phẩm:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              HtmlWidget(
                                product.description ?? "",
                              )
                            ],
                          ),
                          // danh gia san pham
                          // san pham lien quan
                        ],
                      ),
                    ),
                  ),
                );
              },
            )),
          );
  }
}
