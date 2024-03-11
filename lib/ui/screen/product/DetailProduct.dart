import 'package:collection/collection.dart';
import 'package:do_an/api/productApi.dart';
import 'package:do_an/constants.dart';
import 'package:do_an/functionHelpers.dart';
import 'package:do_an/modals/Product.dart';
import 'package:do_an/ui/widgets/CarouselSlider.dart';
import 'package:do_an/ui/widgets/Line.dart';
import 'package:do_an/ui/widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

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
      product = DetailProduct.fromJson(res);

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
                            e.type == 1
                                ? handleOntapBottomButton(context, product, 1)
                                : handleOntapBottomButton(context, product, 2);
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
                      icon: const Icon(Icons.shopping_cart), onPressed: () {}),
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
                            children: [
                              const Text("Mô tả sản phẩm:",
                                  style: TextStyle(
                                      fontSize: 22,
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

Future handleOntapBottomButton(
    BuildContext context, DetailProduct product, int type) {
  return showModalBottomSheet(
      backgroundColor: Colors.grey[50],
      context: context,
      builder: (context) {
        return ModalBottomSheetOpen(
          product: product,
          nameButton: type == 2 ? "Mua ngay" : "Add to cart",
          hanldeOntap: () {},
        );
      });
}

class ModalBottomSheetOpen extends StatelessWidget {
  const ModalBottomSheetOpen(
      {super.key,
      required this.product,
      required this.nameButton,
      required this.hanldeOntap});
  final String nameButton;
  final Function hanldeOntap;
  final DetailProduct product;
  @override
  Widget build(BuildContext context) {
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
                      image: base64ToImageObject(product.images[0]),
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
                                      product.name,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  )),
                          Row(
                            children: [
                              SizedBox(
                                  child: Text(
                                formatMoney(product.minprice.toDouble()),
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
                                "${formatMoney(product.maxPrice.toDouble())} vnd",
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
                  ...product.groupOptions!.map((e) => Column(
                        children: [
                          Text(
                            e['groupName'],
                            style: const TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            child: Column(
                              children:
                                  showAllOptions(e['options'] as List<dynamic>),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                  onPressed: () => hanldeOntap,
                  child: Text(
                    nameButton,
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

List<Widget> showAllOptions(List<dynamic> data) {
  final List<dynamic> chunks = data.slices(4).toList();
  return chunks
      .map((item) => Row(
            children: (item as List<dynamic>)
                .map((e) => Padding(
                      padding: const EdgeInsets.all(3),
                      child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[300])),
                          onPressed: () {},
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
