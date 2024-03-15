import 'package:do_an/modals/Cart.dart';
import 'package:do_an/modals/Order.dart';
import 'package:do_an/modals/User.dart';
import 'package:do_an/redux/actions.dart';
import 'package:redux/redux.dart';

class AppState {
  User user;
  bool isLogined;
  bool isLoading;
  List<ItemCart> cart;
  List<dynamic>? orders;
  AppState(
      {required this.user,
      this.orders,
      required this.isLogined,
      required this.isLoading,
      required this.cart});
  AppState coppyWith(
      {User? user,
      bool? isLogined,
      bool? isLoading,
      String? messageError,
      List<dynamic>? orders,
      List<ItemCart>? cart}) {
    return AppState(
        orders: orders ?? this.orders,
        cart: cart ?? this.cart,
        user: user ?? this.user,
        isLogined: isLogined ?? this.isLogined,
        isLoading: isLoading ?? this.isLoading);
  }

  factory AppState.init() {
    return AppState(
      orders: List.empty(),
      cart: List.empty(),
      user: User.init(),
      isLogined: false,
      isLoading: false,
    );
  }
}

class GetState {
  final User user;
  final bool isLoggedIn;
  final bool isLoading;
  final List<ItemCart> cart;
  final void Function(User user, List<ItemCart> items, List<dynamic>? order)
      login;
  final void Function(bool isLoading) setLoading;
  final void Function(bool isLogout) logout;

  const GetState(
      {required this.login,
      required this.logout,
      required this.setLoading,
      required this.isLoading,
      required this.isLoggedIn,
      required this.cart,
      required this.user});
  static fromStore(Store<AppState> store) {
    return GetState(
        cart: store.state.cart,
        logout: (bool isLogout) => store.dispatch(Logout(isLogout: isLogout)),
        isLoggedIn: store.state.isLogined,
        isLoading: store.state.isLoading,
        user: store.state.user,
        setLoading: (bool isLoading) =>
            store.dispatch(StateLoading(isLoading: isLoading)),
        login: (User user, List<ItemCart> items, List<dynamic>? order) => store
            .dispatch(LoginSucess(user: user, items: items, order: order)));
  }
}
