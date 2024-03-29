import 'package:do_an/modals/Cart.dart';
import 'package:do_an/modals/Notification.dart';
import 'package:do_an/modals/User.dart';
import 'package:do_an/redux/actions.dart';
import 'package:do_an/services/NotificationServices.dart';
import 'package:redux/redux.dart';

class AppState {
  NotificationServices services;
  User user;
  bool isLogined;
  bool isLoading;
  List<ItemCart> cart;
  List<dynamic>? orders;
  List<NotificationUser> notifications;
  AppState(
      {required this.user,
      required this.services,
      required this.notifications,
      this.orders,
      required this.isLogined,
      required this.isLoading,
      required this.cart});
  AppState coppyWith(
      {User? user,
      bool? isLogined,
      bool? isLoading,
      List<NotificationUser>? notifications,
      String? messageError,
      List<dynamic>? orders,
      List<ItemCart>? cart}) {
    return AppState(
        services: this.services,
        notifications: notifications ?? this.notifications,
        orders: orders ?? this.orders,
        cart: cart ?? this.cart,
        user: user ?? this.user,
        isLogined: isLogined ?? this.isLogined,
        isLoading: isLoading ?? this.isLoading);
  }

  factory AppState.init() {
    return AppState(
      notifications: List.empty(),
      orders: List.empty(),
      cart: List.empty(),
      user: User.init(),
      isLogined: false,
      isLoading: false,
      services: NotificationServices(),
    );
  }
}

class GetState {
  final User user;
  final bool isLoggedIn;
  final bool isLoading;
  final List<ItemCart> cart;
  final void Function(User user, List<ItemCart> items, List<dynamic>? order,
      List<NotificationUser>? notifications) login;
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
        login: (User user, List<ItemCart> items, List<dynamic>? order,
                List<NotificationUser>? notifications) =>
            store.dispatch(LoginSucess(
                user: user,
                items: items,
                order: order,
                notifications: notifications)));
  }
}
