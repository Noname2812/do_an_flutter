import 'package:do_an/modals/User.dart';
import 'package:do_an/redux/actions.dart';
import 'package:redux/redux.dart';

class AppState {
  User user;
  bool isLogined;
  bool isLoading;
  String messageError;
  AppState(
      {required this.user,
      required this.isLogined,
      required this.isLoading,
      required this.messageError});
  AppState coppyWith(
      {User? user, bool? isLogined, bool? isLoading, String? messageError}) {
    return AppState(
        messageError: messageError ?? this.messageError,
        user: user ?? this.user,
        isLogined: isLogined ?? this.isLogined,
        isLoading: isLoading ?? this.isLoading);
  }

  factory AppState.init() {
    return AppState(
        user: User.init(),
        isLogined: false,
        isLoading: false,
        messageError: "");
  }
}

class GetState {
  final User user;
  final bool isLoggedIn;
  final bool isLoading;
  final void Function(User user) login;
  final void Function(bool isLoading) setLoading;
  final void Function(bool isLogout) logout;
  const GetState(
      {required this.login,
      required this.logout,
      required this.setLoading,
      required this.isLoading,
      required this.isLoggedIn,
      required this.user});
  static fromStore(Store<AppState> store) {
    return GetState(
        logout: (bool isLogout) => store.dispatch(Logout(isLogout: isLogout)),
        isLoggedIn: store.state.isLogined,
        isLoading: store.state.isLoading,
        user: store.state.user,
        setLoading: (bool isLoading) =>
            store.dispatch(Loading(isLoading: isLoading)),
        login: (User user) => store.dispatch(LoginSucess(user: user)));
  }
}
