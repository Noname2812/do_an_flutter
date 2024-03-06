import 'package:do_an/modals/Category.dart';
import 'package:do_an/modals/Product.dart';
import 'package:do_an/api/index.dart';
import 'package:do_an/ui/widgets/CarouselSlider.dart';
import 'package:do_an/ui/widgets/SliderItem.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];
  List<Category> categories = [];
  bool isLoading = true;
  void getDataHomePage() async {
    final dataProducts = await fetchAll("/product");
    Iterable listProducts = dataProducts['products'];
    final dataCategories = await fetchAll("/category");
    Iterable listCategories = dataCategories['categories'];
    setState(() {
      products =
          listProducts.map((product) => Product.fromJson(product)).toList();
      categories = listCategories
          .map((category) => Category.fromJson(category))
          .toList();
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: TextFormField(
            onSaved: (value) {
              showDialog(
                  context: context,
                  builder: (context) => Dialog.fullscreen(
                        child: Text(value!),
                      ));
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  borderSide: BorderSide.none),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              prefixIcon: const Icon(Icons.search),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "Search",
            ),
          ),
        ),
        const Carousel(),
        SliderItem(
          title: "Categories",
          categories: categories,
          isLoading: isLoading,
          type: 1,
        ),
        SliderItem(
          title: "Products",
          products: products,
          isLoading: isLoading,
          type: 2,
        ),
      ],
    );
  }
}
