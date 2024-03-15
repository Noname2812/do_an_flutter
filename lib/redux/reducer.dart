import 'package:do_an/modals/Cart.dart';
import 'package:do_an/modals/User.dart';
import 'package:do_an/redux/actions.dart';
import 'package:do_an/redux/store.dart';

AppState reducerAppState(AppState state, dynamic action) {
  if (action is LoginSucess) {
    return state.coppyWith(
        user: action.user,
        orders: action.order,
        isLogined: true,
        isLoading: false,
        cart: action.items);
  }
  if (action is Logout) {
    return state.coppyWith(
        user: User.init(),
        isLogined: !action.isLogout,
        isLoading: false,
        cart: List.empty());
  }
  if (action is StateLoading) {
    return state.coppyWith(isLoading: action.isLoading);
  }
  if (action is MessageError) {
    return state.coppyWith(messageError: action.message, isLoading: false);
  }
  if (action is GetCartSuccess) {
    return state.coppyWith(cart: action.cart, isLoading: false);
  }
  if (action is AddToCart) {
    List<ItemCart> temp = state.cart;
    temp.add(action.item);
    return state.coppyWith(cart: temp);
  }
  if (action is ChangeInfo) {
    return state.coppyWith(user: action.user);
  }
  return state;
}
