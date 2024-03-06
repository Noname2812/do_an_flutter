import 'dart:convert';

import 'package:do_an/modals/Category.dart';
import 'package:do_an/modals/Product.dart';
import 'package:do_an/utils/AppColors.dart';
import 'package:flutter/material.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: AppColor.primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: 180,
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 150,
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  color: AppColor.primaryColor.withOpacity(0.2),
                ),
                child: Image.memory(
                  const Base64Decoder()
                      .convert(product.images[0].split(',').last),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueGrey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.minprice}",
                        style: const TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          color: AppColor.primaryColor,
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.shopping_cart,
                              size: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardCategory extends StatelessWidget {
  const CardCategory({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.memory(
                const Base64Decoder().convert(category.image.split(',').last),
                fit: BoxFit.fill,
              )),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          width: 80,
          child: Text(
            category.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 12,
                color: AppColor.primaryColor,
                letterSpacing: 0.4),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
