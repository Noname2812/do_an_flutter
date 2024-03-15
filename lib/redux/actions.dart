import 'package:do_an/modals/Cart.dart';
import 'package:do_an/modals/Order.dart';
import 'package:do_an/modals/Product.dart';
import 'package:do_an/modals/User.dart';

class LoginSucess {
  final List<ItemCart> items;
  final User user;
  final List<dynamic>? order;
  LoginSucess({required this.user, required this.items, this.order});
  @override
  String toString() {
    return 'LoginSucess(user: $user)';
  }
}

class Logout {
  bool isLogout;
  Logout({required this.isLogout});
}

class StateLoading {
  bool isLoading;
  StateLoading({required this.isLoading});
}

class MessageError {
  String message;
  MessageError({required this.message});
}

class GetCartSuccess {
  List<ItemCart> cart;
  GetCartSuccess({required this.cart});
}

class AddToCart {
  ItemCart item;
  AddToCart({required this.item});
}

class ChangeInfo {
  User user;
  ChangeInfo({required this.user});
}

class GetOrderSuccess {
  List<Order> orders;
  GetOrderSuccess({required this.orders});
}
