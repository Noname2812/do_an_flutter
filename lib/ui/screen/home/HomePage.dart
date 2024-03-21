import 'package:do_an/modals/Category.dart';
import 'package:do_an/modals/Product.dart';
import 'package:do_an/api/productApi.dart';
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
        const Carousel(
          list: [
            'assets/images/banner1.jpeg',
            'assets/images/banner2.jpeg',
            'assets/images/banner3.png'
          ],
          isAutoPlay: true,
          height: 200,
          type: 1,
        ),
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
