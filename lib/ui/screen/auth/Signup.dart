import 'dart:convert';
import 'package:do_an/api/authApit.dart';
import 'package:do_an/redux/store.dart';
import 'package:do_an/ui/screen/auth/LayoutAuth.dart';
import 'package:do_an/ui/widgets/Loading.dart';
import 'package:do_an/ui/widgets/SlidePageRoute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'package:redux/redux.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final LocalStorage storage = LocalStorage('auth');
  final _formKey = GlobalKey<FormState>();
  String message = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GetState>(
        converter: (Store<AppState> store) => GetState.fromStore(store),
        builder: (BuildContext context, GetState vm) {
          final mediaQuery = MediaQuery.of(context).size;
          void handleResigter(String email, String pass) async {
            vm.setLoading(true);
            final res = await resigter(email, pass, "register");
            if (res.statusCode == 404) {
              vm.setLoading(false);
              var result = await jsonDecode(res.body);
              message = result["message"];
            } else if (res.statusCode == 500) {
              vm.setLoading(false);
              message = "Please fill a valid email address !";
            } else {
              vm.setLoading(false);
              var result = await jsonDecode(res.body);
              message = result["message"];
            }
          }

          return vm.isLoading
              ? const Loading(isFullScreen: true)
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blue,
                    title: const Text(
                      "Resigter",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  body: SafeArea(
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: mediaQuery.height * .3,
                          width: mediaQuery.width * .5,
                          child: Image.asset(
                            "assets/images/signup.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "Welcome to Buddies.!",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: mediaQuery.width * .06),
                        ),
                        Text(
                          "Create an account and let's get started.",
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600,
                            fontSize: mediaQuery.width * .045,
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.height * .05,
                          child: Text(
                            message,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 18),
                          ),
                        ),
                        Form(
                            key: _formKey,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mediaQuery.width * .05),
                              height: mediaQuery.height * .4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextFormField(
                                    controller: _emailController,
                                    validator: (value) {},
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
                                    controller: _passwordController,
                                    style: GoogleFonts.nunitoSans(),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    validator: (value) {},
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 5),
                                        prefixIcon: const Icon(
                                          Icons.lock_open_rounded,
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
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    style: GoogleFonts.nunitoSans(),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {},
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 5),
                                        prefixIcon: const Icon(
                                          Icons.lock_open_rounded,
                                          color: Colors.purple,
                                        ),
                                        hintText: "Confirm Password",
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
                                  ElevatedButton(
                                      onPressed: () {
                                        bool? isValid =
                                            _formKey.currentState?.validate();
                                        if (isValid!) {
                                          handleResigter(
                                            _emailController.text,
                                            _passwordController.text,
                                          );
                                        }
                                      },
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.symmetric(
                                                  horizontal:
                                                      mediaQuery.width * .11,
                                                  vertical: mediaQuery.height *
                                                      .015)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.blue)),
                                      child: Text(
                                        "Create Account",
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: mediaQuery.width * .04),
                                      ))
                                ],
                              ),
                            )),
                        SizedBox(
                          height: mediaQuery.height * .05,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Login now !",
                                style: GoogleFonts.nunitoSans(),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      SlidePageRoute(
                                        page: LayoutAuth(title: "Login"),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign-in",
                                    style: GoogleFonts.nunitoSans(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    )),
                  ),
                );
        });
  }
}
