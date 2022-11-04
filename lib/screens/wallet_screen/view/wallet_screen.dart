import '/provider/user_details_viewmodel.dart';
import '/screens/paytm/view/payment_cart_screen.dart';
import '/screens/paytm/view/refresh_wallet_controller.dart';
import '/screens/wallet_screen/view/qr_code_popup.dart';
import '/screens/wallet_screen/view/scan_screen.dart';
import '/screens/wallet_screen/view/wallet_screen_controller.dart';
import '/screens/wallet_screen/view_model/wallet_viewmodel.dart';
import '/utils/scroll_remover.dart';
import '/utils/ui_utils.dart';
import '/widgets/app_bar.dart';
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
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
              title: 'Wallet',
              isactionButtonRequired: false,
              isBackButtonRequired: false)),
      body: RefreshIndicator(
        onRefresh: getBalance,
        child: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: ListView(
            children: [
              Stack(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 29, 20, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height:
                                UIUtills().getProportionalHeight(height: 244),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: const Color(0xFF464796),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/ART.svg',
                                  height: UIUtills()
                                      .getProportionalHeight(height: 170),
                                  width: UIUtills()
                                      .getProportionalWidth(width: 142),
                                ),
                                const SizedBox(
                                  height: 200,
                                  width: 40,
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 250,
                              width: 250,
                              decoration: const BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [
                                      Color.fromRGBO(255, 255, 255, 0.25),
                                      Color.fromRGBO(213, 213, 213, 0)
                                    ],
                                    radius: 0.5,
                                  ),
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            height:
                                UIUtills().getProportionalHeight(height: 244),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: UIUtills()
                                                .getProportionalHeight(
                                                    height: 8),
                                            horizontal: UIUtills()
                                                .getProportionalWidth(
                                                    width: 13)),
                                        //height: UIUtills()
                                        // .getProportionalHeight(height: 43),

                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: Text(
                                            UserDetailsViewModel
                                                    .userDetails.username ??
                                                'NA',
                                            style: GoogleFonts.roboto(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          if (await auth.isDeviceSupported()) {
                                            await _authenticate();
                                          }
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
                                                        child: QRCodeDialogBox(
                                                            qrCode: QRcode));
                                                  });
                                            }
                                          }
                                        },
                                        child: SvgPicture.asset(
                                          'assets/images/qr.svg',
                                          height: 41,
                                          width: 41,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Current Balance',
                                            style: GoogleFonts.roboto(
                                                color: const Color(0xFFFFFFFF),
                                                fontSize: UIUtills()
                                                    .getProportionalHeight(
                                                        height: 16),
                                                fontWeight: FontWeight.w700),
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
                                                  style: GoogleFonts.roboto(
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
                                      Text(
                                        'User Id: ${UserDetailsViewModel.userDetails.userID ?? 'NA'}',
                                        style: GoogleFonts.roboto(
                                            color: const Color(0xFFFFFFFF),
                                            fontSize: UIUtills()
                                                .getProportionalHeight(
                                                    height: 16),
                                            fontWeight: FontWeight.w600),
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
                      Text(
                        'ACTIONS',
                        style: GoogleFonts.roboto(
                            color: const Color(0xFF1A1A1A),
                            fontSize:
                                UIUtills().getProportionalHeight(height: 20),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: UIUtills().getProportionalHeight(height: 20),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(116, 126, 241, 0.05),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            if (UserDetailsViewModel.userDetails.isBitsian!) {
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
                                        .getProportionalWidth(width: 20)),
                                child: SvgPicture.asset(
                                    'assets/images/add_money.svg')),
                            SizedBox(
                              width:
                                  UIUtills().getProportionalWidth(width: 14.00),
                            ),
                            Text(
                              'Add Money',
                              style: GoogleFonts.roboto(
                                  color: const Color(0xFF1A1A1A),
                                  fontSize: UIUtills()
                                      .getProportionalHeight(height: 20),
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width:
                                  UIUtills().getProportionalWidth(width: 155),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: UIUtills().getProportionalHeight(height: 20),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(116, 126, 241, 0.05),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 1),
                            InkWell(
                              onTap: () async {
                                if (!mounted) {}
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: const ScanningView(),
                                    withNavBar: false);
                              },
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: UIUtills()
                                          .getProportionalWidth(width: 22)),
                                  child: SvgPicture.asset(
                                      'assets/images/send_money.svg'),
                                ),
                                SizedBox(
                                  width: UIUtills()
                                      .getProportionalHeight(height: 17),
                                ),
                                Text(
                                  'Send Money',
                                  style: GoogleFonts.roboto(
                                      color: const Color(0xFF1A1A1A),
                                      fontSize: UIUtills()
                                          .getProportionalHeight(height: 20),
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: UIUtills()
                                      .getProportionalWidth(width: 150),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                ),
                              ]),
                            ),
                          ],
                        ),
                      )
                    ],
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
