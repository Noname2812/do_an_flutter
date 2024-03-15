import 'package:do_an/api/productApi.dart';
import 'package:do_an/modals/Product.dart';
import 'package:do_an/ui/widgets/CartItem.dart';
import 'package:do_an/ui/widgets/EmptyWidget.dart';
import 'package:do_an/ui/widgets/Loading.dart';
import 'package:do_an/ui/widgets/layout.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key, required this.param});
  final String param;
  @override
  State<StatefulWidget> createState() => ListProductState();
}

class ListProductState extends State<ListProduct> {
  final ScrollController _sc = ScrollController();
  List<Product> _products = [];
  int offset = 0;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        offset += 10;
        getData(widget.param, offset);
      }
    });
    getData(widget.param, offset);
  }

  void getData(String id, int offset) async {
    final dataProducts = await getProductsByQuery(id, 0);
    Iterable listProducts = dataProducts['products'];
    setState(() {
      if (!isLoading) {
        isLoading = true;
      }
      var temp = [..._products];
      _products = [
        ...temp,
        ...listProducts.map((product) => Product.fromJson(product))
      ];
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 5,
        title: const SearchBarApp(),
        toolbarHeight: 40,
        actions: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.filter_list_alt),
            ),
          )
        ],
      ),
      body: isLoading
          ? const Loading(
              isFullScreen: true,
            )
          : showProducts(_products),
      resizeToAvoidBottomInset: false,
    );
  }
}

Widget showProducts(List<Product> products) {
  return products.isEmpty
      ? EmptyWidget("No results", "no_results.png")
      : GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, int index) {
            return FittedBox(
              child: CartProduct(
                product: products[index],
              ),
            );
          },
        );
}
