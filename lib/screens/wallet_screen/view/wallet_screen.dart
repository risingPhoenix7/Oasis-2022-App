import '/provider/user_details_viewmodel.dart';
import '/screens/paytm/view/payment_cart_screen.dart';
import '/screens/paytm/view/refresh_wallet_controller.dart';
import '/screens/wallet_screen/view/qr_code_popup.dart';
import '/screens/wallet_screen/view/scan_screen.dart';
import '/screens/wallet_screen/view/wallet_screen_controller.dart';
import '/screens/wallet_screen/view_model/wallet_viewmodel.dart';
import '/utils/scroll_remover.dart';
import '/utils/ui_utils.dart';
import '/widgets/error_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'add_money_screens/addMoney.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int? amountToAdd;
  int? userid;
  int? amountToSend;
  late ValueNotifier<bool> isLoading = ValueNotifier(true);
  late ValueNotifier<bool> isLoadingQrCode = ValueNotifier(true);

  // ignore: non_constant_identifier_names
  String QRcode = '';
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool authenticated = true;

  @override
  void initState() {
    RefreshWalletController.toRefresh.addListener(() {
      getBalance();
    });
    getBalance();
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    WalletScreenController.isSuccess.addListener(() async {
      await getBalance();
      WalletScreenController.isSuccess.value = false;
    });
  }

  Future<void> getBalance() async {
    await WalletViewModel().getBalance();
    setState(() {
      isLoading.value = false;
    });
    if (WalletViewModel.error != null) {
      print('goes here');
      setState(() {
        isLoading.value = false;
      });
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: ErrorDialog(errorMessage: WalletViewModel.error!),
            );
          });
    } else {
      setState(() {
        isLoading.value = false;
      });
    }
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (_) {
      canCheckBiometrics = false;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (_) {
      availableBiometrics = <BiometricType>[];
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
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

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getBalance,
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: ListView(
            children: [
              Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 34, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              UIUtills().getProportionalWidth(width: 8),
                              0,
                              0,
                              UIUtills().getProportionalHeight(height: 28)),
                          child: Text(
                            'Wallet',
                            style: GoogleFonts.openSans(
                                color: const Color(0xFFFFFFFF),
                                fontSize: UIUtills()
                                    .getProportionalHeight(height: 28),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Stack(
                          children: [
                            Image.asset(
                              'assets/images/wallet.png',
                              height:
                                  UIUtills().getProportionalHeight(height: 244),
                              width: MediaQuery.of(context).size.width,
                            ),
                            Container(
                              color: Colors.transparent,
                              height:
                                  UIUtills().getProportionalHeight(height: 244),
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 20, 15, 15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 10 ,width: MediaQuery.of(context).size.width,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'User ID- ${UserDetailsViewModel.userDetails.userID ?? 'NA'}',
                                              style: GoogleFonts.openSans(
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  fontSize: UIUtills()
                                                      .getProportionalHeight(
                                                          height: 14),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              UserDetailsViewModel
                                                      .userDetails.username ??
                                                  'NA',
                                              style: GoogleFonts.openSans(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            print('clicked');
                                            if (await auth
                                                .isDeviceSupported()) {
                                              print(authenticated);
                                              await _authenticate();
                                              print(authenticated);
                                            }
                                            print('authenticated');
                                            if (authenticated) {
                                              if (UserDetailsViewModel
                                                          .userDetails.userID ==
                                                      null ||
                                                  UserDetailsViewModel
                                                          .userDetails.userID ==
                                                      '') {
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: ErrorDialog(
                                                            errorMessage:
                                                                'User id not found'),
                                                      );
                                                    });
                                              } else {
                                                QRcode = await WalletViewModel()
                                                    .refreshQrCode(int.parse(
                                                        UserDetailsViewModel
                                                            .userDetails
                                                            .userID!));
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child:
                                                              QRCodeDialogBox(
                                                                  qrCode:
                                                                      QRcode));
                                                    });
                                              }
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/qr.svg',
                                            height: 31,
                                            width: 31,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Current Balance',
                                              style: GoogleFonts.openSans(
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                  fontSize: UIUtills()
                                                      .getProportionalHeight(
                                                          height: 16),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            ValueListenableBuilder(
                                              valueListenable: isLoading,
                                              builder:
                                                  (context, bool value, child) {
                                                if (isLoading.value) {
                                                  return const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        backgroundColor:
                                                            Colors.black,
                                                      )));
                                                } else {
                                                  return Text(
                                                    'Rs. ${WalletViewModel.balance}',
                                                    style: GoogleFonts.openSans(
                                                        color: const Color(
                                                            0xFFFFFFFF),
                                                        fontSize: UIUtills()
                                                            .getProportionalHeight(
                                                                height: 24),
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: UIUtills().getProportionalHeight(height: 20),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: UIUtills().getProportionalWidth(width: 13)),
                          child: Row(
                            children: [
                              Container(
                                width:
                                    UIUtills().getProportionalWidth(width: 171),
                                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromRGBO(209, 154, 8, 1),
                                      Color.fromRGBO(254, 212, 102, 1),
                                      Color.fromRGBO(227, 186, 79, 1),
                                      Color.fromRGBO(209, 154, 8, 1),
                                      Color.fromRGBO(209, 154, 8, 1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        if (!mounted) {}
                                        PersistentNavBarNavigator.pushNewScreen(
                                            context,
                                            screen: const ScanningView(),
                                            withNavBar: false);
                                      },
                                      child: Row(children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 22)),
                                          child: SvgPicture.asset(
                                            'assets/images/send_money.svg',
                                            width: UIUtills()
                                                .getProportionalWidth(width: 22),
                                            height: UIUtills()
                                                .getProportionalHeight(
                                                    height: 26),
                                          ),
                                        ),
                                        SizedBox(
                                          width: UIUtills()
                                              .getProportionalHeight(height: 13),
                                        ),
                                        Text(
                                          'Send Money',
                                          style: GoogleFonts.openSans(
                                              color: const Color(0xFF1A1A1A),
                                              fontSize: UIUtills()
                                                  .getProportionalHeight(
                                                      height: 16),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: UIUtills().getProportionalWidth(width: 20),
                              ),

                                 Container(
                                  width:
                                      UIUtills().getProportionalWidth(width: 171),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(209, 154, 8, 1),
                                        Color.fromRGBO(254, 212, 102, 1),
                                        Color.fromRGBO(227, 186, 79, 1),
                                        Color.fromRGBO(209, 154, 8, 1),
                                        Color.fromRGBO(209, 154, 8, 1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      if (UserDetailsViewModel
                                          .userDetails.isBitsian!) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AddMoneyScreen()));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    const PaymentCartScreen()));
                                      }
                                    },
                                    child: Row(children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 20)),
                                          child: SvgPicture.asset(
                                            'assets/images/addMoney.svg',
                                            height: 22,
                                            width: 26,
                                          )),
                                      SizedBox(
                                        width: UIUtills()
                                            .getProportionalWidth(width: 14.00),
                                      ),
                                      Text(
                                        'Add Money',
                                        style: GoogleFonts.openSans(
                                            color: Colors.black,
                                            fontSize: UIUtills()
                                                .getProportionalWidth(width: 16),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ]),
                                  ),
                                ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(

                            width: UIUtills().getProportionalWidth(width: 388),
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(26, 28, 28, 1),
                                borderRadius: BorderRadius.circular(10.79)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16, 14, 16, 14),
                              child: Row(
                                children: [
                                  Container(
                                      height: UIUtills()
                                          .getProportionalHeight(height: 46),
                                      width: UIUtills()
                                          .getProportionalWidth(width: 46),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Center(
                                            child: SvgPicture.asset(
                                          'assets/images/Kind_points.svg',
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 23),
                                          width: UIUtills()
                                              .getProportionalWidth(width: 26),
                                          color: Colors.black,
                                        )),
                                      )
                                  ),
                                  SizedBox(width: UIUtills().getProportionalWidth(width: 12),
                                  ),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(
                                    'Kind Points',
                                    style: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontSize: UIUtills()
                                            .getProportionalHeight(
                                            height: 16),
                                        fontWeight: FontWeight.w600),
                                  ),
                                    Text(
                                      '2541',
                                      style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontSize: UIUtills()
                                              .getProportionalHeight(
                                              height: 20),
                                          fontWeight: FontWeight.w700),
                                    ),],),

                                  Padding(
                                    padding:  EdgeInsets.only(left: UIUtills().getProportionalWidth(width: 80)),
                                    child: Container(

                                        padding:
                                        const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color.fromRGBO(209, 154, 8, 1),
                                              Color.fromRGBO(254, 212, 102, 1),
                                              Color.fromRGBO(227, 186, 79, 1),
                                              Color.fromRGBO(209, 154, 8, 1),
                                              Color.fromRGBO(209, 154, 8, 1),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),

                                          child: Row(children: [
                                            Padding(
                                                padding: EdgeInsets.fromLTRB( UIUtills()
                                                    .getProportionalWidth(
                                                    width: 24),0 ,0 , 0),
                                               ),

                                            Text(
                                              'Claim now',
                                              style: GoogleFonts.openSans(
                                                  color: Colors.black,
                                                  fontSize: UIUtills()
                                                      .getProportionalWidth(width: 14),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          SizedBox(width: 24)
                                          ]),

                                      ),
                                  ),


                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
