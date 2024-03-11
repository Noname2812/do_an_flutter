import 'package:do_an/modals/User.dart';

class LoginSucess {
  final User user;
  LoginSucess({required this.user});
  @override
  String toString() {
    return 'LoginSucess(user: $user)';
  }
}

class Logout {
  bool isLogout;
  Logout({required this.isLogout});
}

class Loading {
  bool isLoading;
  Loading({required this.isLoading});
}

class MessageError {
  String message;
  MessageError({required this.message});
}
