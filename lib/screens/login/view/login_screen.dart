import 'dart:ui';

import '/utils/ui_utils.dart';
import '/widgets/error_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../main.dart';
import '../../../utils/error_messages.dart';
import '../../../widgets/loader.dart';
import '../repository/model/data.dart';
import '../repository/model/gloginData.dart';
import '../view_model/glogin_view_model.dart';
import '../view_model/login_view_model.dart';

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

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel loginViewModel = LoginViewModel();
  GoogleLoginViewModel googleLoginViewModel = GoogleLoginViewModel();
  TextEditingController usernameController = TextEditingController(),
      passwordController = TextEditingController();
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
    //  print(UIUtills().getProportionalWidth(width: 428));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFfafaff),
        body: !isLoaderVisible
            ? Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/images/circle1.svg',
                        height: UIUtills().getProportionalHeight(height: 404),
                        semanticsLabel: 'Acme Logo'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 1,
                        ),
                        SvgPicture.asset('assets/images/circle2.svg',
                            height:
                                UIUtills().getProportionalHeight(height: 390),
                            semanticsLabel: 'Acme Logo'),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20,
                      UIUtills().getProportionalHeight(height: 117), 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            height:
                                UIUtills().getProportionalHeight(height: 162),
                            width: UIUtills().getProportionalWidth(width: 128),
                          ),
                          Text(
                            'BOSM',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: UIUtills()
                                    .getProportionalHeight(height: 36),
                                fontWeight: FontWeight.w700,
                                color: const Color.fromRGBO(0, 0, 0, 0.75)),
                          ),
                          Text(
                            'Official BOSM App 2022',
                            style: TextStyle(
                                fontFamily: 'Poppins1',
                                fontWeight: FontWeight.w500,
                                fontSize: UIUtills()
                                    .getProportionalHeight(height: 16),
                                color: const Color.fromRGBO(0, 0, 0, 1)),
                          ),
                          SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 40),
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.grey),
                            controller: usernameController,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: 'Enter your email',
                              hintStyle:
                                  TextStyle(fontSize: 14.0, color: Colors.grey),
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: ImageIcon(
                                AssetImage(
                                  'assets/images/email1.png',
                                ),
                                color: Color(0xFF313131),
                              ),
                              // suffixIcon: IconButton(
                              //     onPressed: () {
                              //       usernameController.clear();
                              //     },
                              //     icon: const Icon(Icons.close,
                              //         color: Colors.grey, size: 15)),
                            ),
                          ),
                          SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 20),
                          ),
                          ValueListenableBuilder(
                            valueListenable: isPwdHidden,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return TextFormField(
                                  style: const TextStyle(color: Colors.grey),
                                  controller: passwordController,
                                  obscureText: isPwdHidden.value,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    hintText: 'Enter your password',
                                    hintStyle: const TextStyle(
                                        fontSize: 14.0, color: Colors.grey),
                                    labelStyle:
                                        const TextStyle(color: Colors.black),
                                    prefixIcon: const ImageIcon(
                                      AssetImage(
                                          'assets/images/carbon_password.png'),
                                      color: Color(0xFF313131),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        isPwdHidden.value == false
                                            ? isPwdHidden.value = true
                                            : isPwdHidden.value = false;
                                      },
                                      icon: Icon(
                                        isPwdHidden.value
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.visibility_off_sharp,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                    ),
                                  ));
                            },
                          ),
                          SizedBox(
                              height:
                                  UIUtills().getProportionalHeight(height: 40)),
                          Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  blurRadius: 4.38, // soften the shadow
                                  //extend the shadow
                                  offset: Offset(
                                    0, // Move to right 5  horizontally
                                    4.38, // Move to bottom 5 Vertically
                                  ),
                                )
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (usernameController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty) {
                                  setState(() {
                                    isLoaderVisible = true;
                                    statusTypeGoogle = false;
                                  });
                                  authOrGoogleAuthResult =
                                      loginViewModel.authenticate(
                                          usernameController.text.trim(),
                                          passwordController.text.trim(),
                                          false);
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
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(3, 3, 3, 1),
                                        Color(0XFF3f3f3f)
                                      ],
                                      end: Alignment.centerRight,
                                      begin: Alignment.centerLeft),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  width: UIUtills()
                                      .getProportionalWidth(width: 324),
                                  height: UIUtills()
                                      .getProportionalWidth(width: 63),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalHeight(height: 22)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 20),
                          ),
                          SignInButton(
                            Buttons.Google,
                            text: 'Login using BITS mail',
                            elevation: 0,
                            onPressed: () async {
                              try {
                                await _googleSignIn.signIn().then((result) {
                                  result?.authentication.then((googleKey) {
                                    setState(() {
                                      isLoaderVisible = true;
                                      statusTypeGoogle = true;
                                    });
                                    authOrGoogleAuthResult =
                                        googleLoginViewModel.authenticate(
                                            googleKey.idToken, true);
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
                            

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     SvgPicture.asset('assets/images/google.svg',
                            //         semanticsLabel: 'Acme Logo'),
                            //     SizedBox(
                            //       width: UIUtills()
                            //           .getProportionalWidth(width: 20),
                            //     ),
                            //     const Text(
                            //       'Sign in with Google',
                            //       style: TextStyle(
                            //           fontFamily: 'Poppins1',
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.w400,
                            //           color: Colors.black),
                            //     ),
                            //   ],
                            // ),
                          ),
                          TextButton(
    onPressed: () => throw Exception(),
    child: const Text("Throw Test Exception"),
),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Made with',
                            style: TextStyle(
                                fontFamily: 'Poppins1',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: UIUtills().getProportionalHeight(height: 5),
                          ),
                          SvgPicture.asset('assets/images/heart.svg',
                              semanticsLabel: 'Acme Logo'),
                          SizedBox(
                            width: UIUtills().getProportionalWidth(width: 5),
                          ),
                          const Text(
                            'by DVM',
                            style: TextStyle(
                                fontFamily: 'Poppins1',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ])
            : statusTypeGoogle
                ? FutureBuilder<GoogleAuthResult>(
                    future: authOrGoogleAuthResult,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data?.error == null) {
                          Future.microtask(() {
                            RestartWidget.restartApp(context);
                            Navigator.of(context, rootNavigator: true)
                                .pushNamedAndRemoveUntil(
                                    'home', (route) => true);
                          });
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
                  )
                : FutureBuilder<AuthResult>(
                    future: authOrGoogleAuthResult,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data?.error == null) {
                          Future.microtask(() =>
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamedAndRemoveUntil(
                                      'home', (route) => true));
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
