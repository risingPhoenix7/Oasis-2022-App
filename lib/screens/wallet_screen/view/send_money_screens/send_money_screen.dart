import 'package:oasis_2022/screens/wallet_screen/view/send_money_screens/updatedSendMoneyDialog.dart';
import 'package:oasis_2022/widgets/OasisSnackbar.dart';

import '/provider/user_details_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';

import '/../../../utils/ui_utils.dart';
import '/../../../widgets/app_bar.dart';
import '../../view_model/wallet_viewmodel.dart';
import '../wallet_screen_controller.dart';
import 'send_money_dialog_widget.dart';

class SendMoneyScreen extends StatefulWidget {
  SendMoneyScreen({super.key, required this.userId});

  String userId;

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  int amountToSend = 0;
  bool isLoading = false;
  late int balance = 0;
  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool authenticated = true;
  String letter = '';
  TextEditingController textEditingController = TextEditingController();


  getFirstLetterOfName(String name) {
    name.trim();
    letter = name[0];
  }

  @override
  void initState() {
    WalletScreenController.returnToWalletScreen.addListener(() {
      Navigator.of(context).pop();
    });
    getFirstLetterOfName(UserDetailsViewModel.userDetails.username ?? "N/A");
    super.initState();
  }

  Future<void> _authenticate() async {
    authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to view QR',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
            title: "Send Money",
            isactionButtonRequired: false,
            isBackButtonRequired: true),
      ),
      backgroundColor: const Color(0XFFFAFAFF),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Positioned(
            bottom: 20,
            left: 20,
            child: isLoading
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: LinearProgressIndicator(
                        color: Colors.black,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      if (!isLoading) {
                        setState(() {
                          isLoading = true;
                        });
                        amountToSend = int.parse(textEditingController.text);
                        if (textEditingController.text.isEmpty) {
                          var snackBar = CustomSnackBar().oasisSnackBar("Enter a value");
                          if (!mounted) {}
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        if (int.parse(textEditingController.text) == 0 ||
                            int.parse(textEditingController.text) < 0) {
                          var snackBar = CustomSnackBar().oasisSnackBar("Enter a non-zero positive value");
                          if (!mounted) {}
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          if (kDebugMode) {
                            print("object");
                          }
                          if (await auth.isDeviceSupported()) {
                            await _authenticate();
                          }
                          if (authenticated) {
                            bool isSuccess;
                            int id = int.parse(widget.userId);
                            try {
                              await WalletViewModel()
                                  .sendMoney(id, amountToSend);

                              isSuccess = true;
                            } catch (e) {
                              isSuccess = false;
                            }
                            if (isSuccess) {
                              WalletScreenController.isSuccess.value = true;
                            }
                            if (!mounted) {}
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    child: UpdatedSendMoneyDialogBox(
                                      isSuccessful: isSuccess,
                                    ),
                                  );
                                });
                          }
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      // alignment: Alignment.bottomCenter,
                      width: UIUtills().getProportionalWidth(width: 388),
                      height: UIUtills().getProportionalHeight(height: 72.00),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(45, 45, 45, 1),
                            Color.fromRGBO(0, 0, 0, 1)
                          ],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.20),
                            blurRadius: 3.00,
                            offset: Offset(0, 2.00),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(
                          UIUtills().getProportionalWidth(width: 15.00),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Send Money',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize:
                                  UIUtills().getProportionalWidth(width: 20.00),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18, left: 32, right: 32),
            child: Container(
              width: UIUtills().getProportionalWidth(width: 364.00),
              height: UIUtills().getProportionalHeight(height: 300.00),
              decoration: BoxDecoration(
                //color: const Color(0xFFFFFFFF),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  )
                ],
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFFFFFFF),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: UIUtills().getProportionalHeight(height: 21.00)),
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/addMoneyScreenElement.png',
                            width:
                                UIUtills().getProportionalWidth(width: 76.00),
                            height:
                                UIUtills().getProportionalHeight(height: 76.00),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: UIUtills()
                                      .getProportionalHeight(height: 10.50)),
                              Text(
                                letter,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 32.00),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: UIUtills()
                                        .getProportionalWidth(width: -0.41)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                      height: UIUtills().getProportionalHeight(height: 14.00)),
                  Text(
                    'User ID: ${UserDetailsViewModel.userDetails.userID}',
                    style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                        fontSize: UIUtills().getProportionalWidth(width: 16.00),
                        fontWeight: FontWeight.w400,
                        letterSpacing:
                            UIUtills().getProportionalWidth(width: -0.41)),
                  ),
                  SizedBox(
                      height: UIUtills().getProportionalHeight(height: 23.00)),
                  Text(
                    'Send amount',
                    style: GoogleFonts.roboto(
                        color: const Color(0xFF171717),
                        fontSize: UIUtills().getProportionalWidth(width: 20.00),
                        fontWeight: FontWeight.w600,
                        letterSpacing:
                            UIUtills().getProportionalWidth(width: -0.41)),
                  ),
                  SizedBox(
                      height: UIUtills().getProportionalHeight(height: 32.00)),
                  Container(
                    alignment: Alignment.center,
                    width: UIUtills().getProportionalWidth(width: 82),
                    height: UIUtills().getProportionalHeight(height: 40.00),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '₹ ',
                          style: GoogleFonts.roboto(
                              color: const Color(0xFF171717),
                              fontSize:
                                  UIUtills().getProportionalWidth(width: 24.00),
                              fontWeight: FontWeight.w700,
                              letterSpacing: UIUtills()
                                  .getProportionalWidth(width: -0.41)),
                        ),
                        Flexible(
                          child: TextField(
                            controller: textEditingController,
                            cursorColor: Colors.black,
                            textAlign: TextAlign.right,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4)
                            ],
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.roboto(
                                color: const Color(0xFF171717),
                                fontSize: UIUtills()
                                    .getProportionalWidth(width: 24.00),
                                fontWeight: FontWeight.w700,
                                letterSpacing: UIUtills()
                                    .getProportionalWidth(width: -0.41)),
                            decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                      height: UIUtills().getProportionalHeight(height: 30.00)),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
