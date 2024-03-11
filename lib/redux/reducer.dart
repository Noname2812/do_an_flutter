import 'package:do_an/redux/actions.dart';
import 'package:do_an/redux/store.dart';

AppState reducerAppState(AppState state, dynamic action) {
  if (action is LoginSucess) {
    return state.coppyWith(
        user: action.user, isLogined: true, isLoading: false);
  }
  if (action is Logout) {
    return state.coppyWith(
        user: null, isLogined: !action.isLogout, isLoading: false);
  }
  if (action is Loading) {
    return state.coppyWith(isLoading: action.isLoading);
  }
  if (action is MessageError) {
    return state.coppyWith(messageError: action.message, isLoading: false);
  }
  return state;
}
