import 'dart:ui';

import '/utils/ui_utils.dart';
import '/widgets/error_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../utils/error_messages.dart';
import '../../../widgets/loader.dart';
import '../repository/model/data.dart';
import '../view_model/glogin_view_model.dart';
import '../view_model/login_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  hostedDomain: "pilani.bits-pilani.ac.in",
  scopes: <String>[
    'email',
  ],
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool isHidden = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late AnimationController iconColorController;
  Animation? animation;

  late final AnimationController backgroundRotationController =
  AnimationController(
      vsync: this, duration: const Duration(milliseconds: 10000))
    ..repeat();
  late final Animation<double> _rotationAnimation =
  Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: backgroundRotationController, curve: Curves.linear));

  late final AnimationController passwordTextFieldShakeController =
  AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
  );
  late final Animation<Offset> _passwordOffsetAnimation =
  TweenSequence<Offset>([
    TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset.zero, end: const Offset(0.125, 0.0)),
        weight: 1),
    TweenSequenceItem(
        tween: Tween<Offset>(begin: const Offset(0.125, 0.0), end: Offset.zero),
        weight: 1),
    TweenSequenceItem(
        tween:
        Tween<Offset>(begin: Offset.zero, end: const Offset(-0.0625, 0.0)),
        weight: 1),
    TweenSequenceItem(
        tween:
        Tween<Offset>(begin: const Offset(-0.0625, 0.0), end: Offset.zero),
        weight: 1),
  ]).animate(CurvedAnimation(
    parent: passwordTextFieldShakeController,
    curve: Curves.linear,
  ));

  late final AnimationController usernameTextFieldShakeController =
  AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
  );
  late final Animation<Offset> _usernameOffsetAnimation =
  TweenSequence<Offset>([
    TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset.zero, end: const Offset(0.125, 0.0)),
        weight: 1),
    TweenSequenceItem(
        tween: Tween<Offset>(begin: const Offset(0.125, 0.0), end: Offset.zero),
        weight: 1),
    TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset.zero, end: Offset(-0.0625, 0.0)),
        weight: 1),
    TweenSequenceItem(
        tween:
        Tween<Offset>(begin: const Offset(-0.0625, 0.0), end: Offset.zero),
        weight: 1),
  ]).animate(CurvedAnimation(
    parent: usernameTextFieldShakeController,
    curve: Curves.linear,
  ));

  @override
  void initState() {
    iconColorController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..addListener(() {
      setState(() {});
    });
    animation = ColorTween(
      begin: const Color.fromRGBO(255, 255, 255, 0.7),
      end: const Color(0xFFF8D848),
    ).animate(iconColorController);
    super.initState();
  }

  LoginViewModel loginViewModel = LoginViewModel();
  GoogleLoginViewModel googleLoginViewModel = GoogleLoginViewModel();
  var authOrGoogleAuthResult;
  bool isLoaderVisible = false, statusTypeGoogle = false;
  ValueNotifier<bool> isPwdHidden = ValueNotifier(true);

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: !isLoaderVisible
            ? Stack(
          children: [
            ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                child: RotationTransition(
                    turns: _rotationAnimation,
                    child: SvgPicture.asset(
                        "assets/images/loginBackground.svg"))),
            Positioned(
              bottom: 39,
              left: 0,
              right: 0,
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Made with 💛 by DVM",
                      style: GoogleFonts.openSans(
                          color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: UIUtills()
                            .getProportionalHeight(height: 151)),
                    child: SvgPicture.asset(
                        "assets/images/login_screen_logo.svg"),
                  ),
                  Form(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top:
                            UIUtills().getProportionalHeight(height: 59)),
                        child: SizedBox(
                          width: 360,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: UIUtills()
                                        .getProportionalHeight(height: 13)),
                                child: SlideTransition(
                                  position: _usernameOffsetAnimation,
                                  child: TextFormField(
                                    cursorColor: const Color.fromRGBO(
                                        255, 255, 255, 0.7),
                                    controller: usernameController,
                                    validator: (value) {},
                                    style: GoogleFonts.openSans(
                                        fontSize: 16,
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 0.7)),
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.only(
                                            top: 19, bottom: 19, left: 24),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10.7936),
                                            borderSide: const BorderSide(
                                                color: Color(0xFFF8D848))),
                                        filled: true,
                                        fillColor: const Color(0xFF1A1C1C),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10.7936)),
                                        hintText: "Enter your username",
                                        hintStyle: GoogleFonts.openSans(
                                            fontSize: 16,
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.7))),
                                  ),
                                ),
                              ),
                              SlideTransition(
                                position: _passwordOffsetAnimation,
                                child: TextFormField(
                                  cursorColor: const Color.fromRGBO(
                                      255, 255, 255, 0.7),
                                  controller: passwordController,
                                  obscureText: isHidden,
                                  style: GoogleFonts.openSans(
                                      fontSize: 16,
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.7)),
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                          top: 19, bottom: 19, left: 24),
                                      suffixIcon: IconButton(
                                          focusColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onPressed: () {
                                            bool blockTap = true;
                                            if (iconColorController.value !=
                                                1 ||
                                                iconColorController.value !=
                                                    0) {
                                              blockTap = true;
                                            }
                                            if (iconColorController.value ==
                                                1 &&
                                                blockTap) {
                                              isHidden = !isHidden;
                                              iconColorController.reverse();
                                            }
                                            if (blockTap &&
                                                iconColorController.value ==
                                                    0) {
                                              isHidden = !isHidden;
                                              iconColorController.forward();
                                            }
                                          },
                                          icon: Icon(
                                              Icons.visibility_outlined,
                                              color: animation?.value ??
                                                  const Color.fromRGBO(
                                                      255, 255, 255, 0.7))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.7936),
                                          borderSide: const BorderSide(
                                              color: Color(0xFFF8D848))),
                                      filled: true,
                                      fillColor: const Color(0xFF1A1C1C),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.7936)),
                                      hintText: "Enter your password",
                                      hintStyle: GoogleFonts.openSans(
                                          fontSize: 16,
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 0.7))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 51, bottom: 22),
                    child: GestureDetector(
                      onTap: () {
                        bool tempBlock = true;
                        if ((passwordController.text.trim().isEmpty ||
                            passwordController.text.trim() == "") &&
                            (usernameController.text.trim().isEmpty ||
                                usernameController.text.trim() == "")) {
                          passwordTextFieldShakeController.reset();
                          usernameTextFieldShakeController.reset();
                          passwordTextFieldShakeController.forward();
                          usernameTextFieldShakeController.forward();
                          tempBlock = false;
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text(
                                        "Enter the password and username"))),
                          ));
                        } else if (tempBlock &&
                            (passwordController.text.trim().isEmpty ||
                                passwordController.text.trim() == "")) {
                          if (passwordTextFieldShakeController.value ==
                              1) {
                            passwordTextFieldShakeController.reset();
                          }
                          passwordTextFieldShakeController.forward();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text("Enter the password"))),
                          ));
                        } else if (tempBlock &&
                            (usernameController.text.trim().isEmpty ||
                                usernameController.text.trim() == "")) {
                          if (usernameTextFieldShakeController.value ==
                              1) {
                            usernameTextFieldShakeController.reset();
                          }
                          usernameTextFieldShakeController.forward();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text("Enter the username"))),
                          ));
                        } else if (usernameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          setState(() {
                            isLoaderVisible = true;
                            statusTypeGoogle = false;
                          });
                          authOrGoogleAuthResult =
                              loginViewModel.authenticate(
                                  usernameController.text.trim(),
                                  passwordController.text.trim(),
                                  true);
                          usernameController.clear();
                          passwordController.clear();
                        } else {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ErrorDialog(
                                      errorMessage: ErrorMessages
                                          .emptyUsernamePassword),
                                );
                              });
                        }
                      },
                      child: Container(
                        height: 52,
                        width: 287,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xFFF8D848),
                            borderRadius: BorderRadius.circular(16)),
                        child: Text(
                          "Login",
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        await _googleSignIn.signIn().then((result) {
                          result?.authentication.then((googleKey) {
                            setState(() {
                              isLoaderVisible = true;
                              statusTypeGoogle = true;
                            });
                            authOrGoogleAuthResult =  googleLoginViewModel
                                .authenticate(googleKey.idToken, true);
                          });
                        });
                      } catch (error) {
                        Future.microtask(() => setState(() {
                          isLoaderVisible = false;
                        }));
                        Future.microtask(() => showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: ErrorDialog(
                                    errorMessage:
                                    ErrorMessages.invalidLogin),
                              );
                            }));
                      }
                    },
                    child: Container(
                      height: 52,
                      width: 287,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: const Border(
                              top: BorderSide(color: Colors.white),
                              left: BorderSide(color: Colors.white),
                              right: BorderSide(color: Colors.white),
                              bottom: BorderSide(color: Colors.white))),
                      child:
                      Row(mainAxisSize: MainAxisSize.min, children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SvgPicture.asset(
                              "assets/images/google_logo.svg"),
                        ),
                        Text(
                          "Login with BITS Mail",
                          style: GoogleFonts.openSans(
                              fontSize: 16, color: Colors.white),
                        )
                      ]),
                    ),
                  )
                ],
              ),
            )
          ],
        )
            : FutureBuilder<AuthResult>(
          future: authOrGoogleAuthResult,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.error == null) {
                Future.microtask(() => Navigator.of(context,
                    rootNavigator: true)
                    .pushNamedAndRemoveUntil('home', (route) => true));
              } else {
                Future.microtask(() => setState(() {
                  isLoaderVisible = false;
                }));
                Future.microtask(() => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: ErrorDialog(
                            errorMessage: ErrorMessages.invalidLogin),
                      );
                    }));
              }
            } else {
              return const Loader();
            }
            return Container();
          },
        ));
  }
}