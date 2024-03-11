import 'package:do_an/modals/index.dart';
import 'package:flutter/material.dart';

List<ItemButtonNavBar> itemsBottomNavigationBav = [
  ItemButtonNavBar(title: "Home", icon: const Icon(Icons.home)),
  ItemButtonNavBar(
      title: "Notifications", icon: const Icon(Icons.notifications)),
  ItemButtonNavBar(title: "Cart", icon: const Icon(Icons.shopping_cart)),
  ItemButtonNavBar(
      title: "User",
      icon: const Icon(
        Icons.account_box_rounded,
      )),
];
List<ItemButtonNavBar> itemsBottomNavigationBavDetailProduct = [
  ItemButtonNavBar(
      type: 1,
      title: "Thêm vào giỏ hàng",
      icon: const Icon(Icons.shopping_cart, color: Colors.white),
      bgColor: Colors.green[400]),
  ItemButtonNavBar(
      type: 2,
      title: "Mua ngay",
      icon: const Icon(
        Icons.payment,
        color: Colors.white,
      ),
      bgColor: Colors.red[600]),
];
const BASE_URL = "do-an-web-be-git-main-top1808s-projects.vercel.app";
