import 'package:do_an/api/authApit.dart';
import 'package:do_an/functionHelpers.dart';
import 'package:do_an/modals/Cart.dart';
import 'package:do_an/modals/Order.dart';
import 'package:do_an/modals/User.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/screen/auth/Signup.dart';
import 'package:do_an/ui/widgets/Loading.dart';
import 'package:do_an/ui/widgets/SlidePageRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:redux/redux.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LocalStorage storage = LocalStorage('auth');
  final _formKey = GlobalKey<FormState>();
  String message = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GetState>(
        converter: (Store<AppState> store) => GetState.fromStore(store),
        builder: (BuildContext context, GetState vm) {
          final mediaQuery = MediaQuery.of(context).size;
          void hanleLogin(String email, String pass) async {
            vm.setLoading(true);
            final resultLogin = await login(email, pass, "login");
            if (resultLogin["message"] == null) {
              List<ItemCart> cart = await getCartByUser(resultLogin["id"]);
              List<dynamic> orders = await getOrderByUser(resultLogin["id"]);
              vm.login(User.fromJson(resultLogin), cart, orders);
            } else {
              vm.setLoading(false);
              message = resultLogin["message"];
            }
          }

          return vm.isLoading
              ? const Loading(isFullScreen: true)
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: mediaQuery.height * .3,
                        width: mediaQuery.width * .5,
                        child: Image.asset(
                          "assets/images/login.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "Welcome Back.!",
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: mediaQuery.width * .06),
                      ),
                      Text(
                        "Login to your account and get started.",
                        style: GoogleFonts.nunitoSans(
                            // color: CustomColors.darkAccent,
                            fontSize: mediaQuery.width * .04),
                      ),
                      SizedBox(
                        height: mediaQuery.height * .04,
                        child: Text(
                          message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      Form(
                          key: _formKey,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: mediaQuery.width * .05),
                            height: mediaQuery.height * .32,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter an email address.';
                                    } else if (!RegExp(
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.[a-zA-Z]{2,}$")
                                        .hasMatch(value)) {
                                      return 'Please enter a valid email address.';
                                    } else {
                                      return null; // No error
                                    }
                                  },
                                  style: GoogleFonts.nunitoSans(),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15),
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: Colors.purple,
                                      ),
                                      hintText: "Email",
                                      hintStyle: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black38),
                                      fillColor: Colors.black12,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none)),
                                ),
                                TextFormField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  style: GoogleFonts.nunitoSans(),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value!.length < 6) {
                                      return 'Value must be at least 6 characters.';
                                    } else if (value.contains(' ')) {
                                      return 'Value cannot contain spaces.';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 5),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.purple,
                                      ),
                                      hintText: "Password",
                                      hintStyle: GoogleFonts.nunitoSans(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black38),
                                      fillColor: Colors.black12,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: BorderSide.none)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: mediaQuery.width * .5),
                                  child: Text(
                                    "Forgot Password?",
                                    textAlign: TextAlign.end,
                                    style: GoogleFonts.nunitoSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      bool? isValid =
                                          _formKey.currentState?.validate();
                                      if (isValid!) {
                                        hanleLogin(_emailController.text.trim(),
                                            _passwordController.text.trim());
                                      }
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              horizontal:
                                                  mediaQuery.width * .125,
                                              vertical:
                                                  mediaQuery.height * .015)),
                                    ),
                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.nunitoSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: mediaQuery.width * .04),
                                    ))
                              ],
                            ),
                          )),
                      SizedBox(
                        height: mediaQuery.height * .03,
                      ),
                      SizedBox(
                        height: mediaQuery.height * .05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.nunitoSans(),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    SlidePageRoute(
                                      page: const SignupPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign-Up",
                                  style: GoogleFonts.nunitoSans(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                );
        });
  }
}
