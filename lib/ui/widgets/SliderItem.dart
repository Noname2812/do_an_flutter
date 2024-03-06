import 'package:do_an/modals/Category.dart';
import 'package:do_an/modals/Product.dart';
import 'package:do_an/ui/widgets/CartItem.dart';
import 'package:do_an/ui/widgets/Loading.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SliderItem extends StatelessWidget {
  const SliderItem(
      {super.key,
      required this.title,
      required this.type,
      this.products,
      this.categories,
      required this.isLoading});
  final String title;
  final List<Product>? products;
  final List<Category>? categories;
  final bool isLoading;
  final int type;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SeeAllWidget(
              route: type == 1 ? "/categories" : "/products",
            ),
          ],
        ),
        isLoading
            ? Loading()
            : (type == 1
                ? ShowListItem(
                    categories: categories,
                    type: 1,
                  )
                : ShowListItem(products: products, type: 2)),
      ],
    );
  }
}

class ShowListItem extends StatelessWidget {
  const ShowListItem(
      {super.key, this.products, this.categories, required this.type});
  final List<Product>? products;
  final List<Category>? categories;
  final int type;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: type == 1 ? 100 : 220,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: categories == null
              ? products!.map((e) => CartProduct(product: e)).toList()
              : categories!
                  .map((item) => CardCategory(
                        category: item,
                      ))
                  .toList(),
        ));
  }
}

class SeeAllWidget extends StatelessWidget {
  const SeeAllWidget({super.key, required this.route});
  final String route;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: const Text(
          "See all",
          style: TextStyle(fontSize: 15, color: Colors.blue),
        ),
      ),
    );
  }
}
