import 'package:oasis_2022/widgets/OasisSnackbar.dart';

import '/provider/user_details_viewmodel.dart';
import '/utils/ui_utils.dart';
import '/widgets/app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

import '../repository/model/paytmResponse.dart';
import '../repository/model/paytmResult.dart';
import '../view_model/paytm_response_view_model.dart';
import '../view_model/paytm_view_model.dart';

class PaymentCartScreen extends StatefulWidget {
  const PaymentCartScreen({Key? key}) : super(key: key);

  @override
  State<PaymentCartScreen> createState() => _PaymentCartScreenState();
}

class _PaymentCartScreenState extends State<PaymentCartScreen> {
  PaytmViewModel paytmViewModel = PaytmViewModel();
  var amountController = TextEditingController();
  late PaytmResponse paytmResponse;

  late PaytmResult _paytmApiResponse;
  late String mid, orderId, txnToken;
  late String amount;
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl =
      "https://securegw.paytm.in/theia/api/v1/initiateTransaction?mid={mid}&orderId={order-id}";
  bool restrictAppInvoke = false;
  bool enableAssist = true;
  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool authenticated = true;
  String letter = '';

  getFirstLetterOfName(String name) {
    name.trim();
    letter = name[0];
  }

  @override
  void initState() {
    getFirstLetterOfName(UserDetailsViewModel.userDetails.username ?? "");
    super.initState();
  }

  Future<void> _paytmInitialResponse() async {
    // paytmViewModel.getPaytmResponse(amountController.text);
    isApiCallInprogress = true;
    _paytmApiResponse =
        await PaytmViewModel().getPaytmResponse(amountController.text);
    mid = _paytmApiResponse.mid;
    orderId = _paytmApiResponse.order_id;
    txnToken = _paytmApiResponse.txntoken;
    amount = amountController.text;
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
            title: "Add Money via Paytm",
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
            child: InkWell(
              onTap: () async {
                if (amountController.text.isEmpty) {
                  var snackBar =  CustomSnackBar().oasisSnackBar('Enter a Value');
                  if (!mounted) {}
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (int.parse(amountController.text) == 0 ||
                    int.parse(amountController.text) < 0) {
                  var snackBar = CustomSnackBar().oasisSnackBar('Enter a non zero postive value');
                  if (!mounted) {}
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  if (kDebugMode) {
                    print("object");
                  }
                  if (await auth.isDeviceSupported()) {
                    await _authenticate();
                    print(authenticated);
                  }
                  if (authenticated) {
                    print('goes here 1');
                    print(isApiCallInprogress);
                    if (!isApiCallInprogress) {
                      print('goes here');
                      await _paytmInitialResponse();
                      await _startTransaction();
                      //TODO: how to check when a paytm transaction is complete
                      // if (result.isEmpty) {
                      //   RefreshWalletController.toRefresh.notifyListeners();
                      //   Navigator.of(context).pop();
                      // }
                    }

                    // bool isSuccess =
                    // await WalletViewModel().addMoney(amountToAdd);
                    // if (kDebugMode) {
                    //   print(isSuccess);
                    // }
                    // if (isSuccess) {
                    //   WalletScreenController.isSuccess.value = true;
                    //   await getBalance();
                    //   if (!mounted) {}
                    //   showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return Align(
                    //           alignment: Alignment.bottomCenter,
                    //           child: AddMoneyDialogBox(
                    //             isSuccessful: isSuccess,
                    //             amount: amountToAdd,
                    //           ),
                    //         );
                    //       });
                    // }
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                // alignment: Alignment.bottomCenter,
                width: UIUtills().getProportionalWidth(width: 388),
                height: UIUtills().getProportionalHeight(height: 72.00),
                // margin: EdgeInsets.symmetric(
                //     horizontal:
                //     UIUtills().getProportionalWidth(width: 20.00)),
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
                      'Add Money',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        fontSize: UIUtills().getProportionalWidth(width: 20.00),
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
              height: UIUtills().getProportionalHeight(height: 370),
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
                // gradient: const LinearGradient(
                //   colors: [
                //     Color.fromRGBO(0, 0, 0, 1),
                //     Color.fromRGBO(45, 45, 45, 1)
                //   ],
                // ),
                color: const Color(0xFFFFFFFF),
              ),
              // margin: EdgeInsets.only(
              //     // left: UIUtills().getProportionalWidth(width: 32.00),
              //     // right: UIUtills().getProportionalWidth(width: 32.00),
              //     top: UIUtills().getProportionalHeight(height: 18.00)),
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
                    'Your amount',
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
                            controller: amountController,
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: UIUtills().getProportionalHeight(height: 30)),
                  Text('DISCLAIMER'),
                  SizedBox(
                      height: UIUtills().getProportionalHeight(height: 10)),
                  Text('Money added via PayTM is non-refundable'),
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

  Future<void> _authenticate() async {
    authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to add money',
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

  Future<void> _startTransaction() async {
    if (txnToken == "") {
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": mid,
      "orderId": orderId,
      "amount": amount,
      "txnToken": txnToken,
      "callbackUrl": callbackUrl,
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke,
      "enableAssist": enableAssist
    };
    print(sendMap);
    try {
      // String callbackUrl = "https://test.bits-apogee.org/wallet/payment_response";
      var response = AllInOneSdk.startTransaction(
        mid,
        orderId,
        amount,
        txnToken,
        callbackUrl,
        isStaging,
        restrictAppInvoke,
        enableAssist,
      );
      response.then((value) {
        print(value);
        print("The process begin");
        setState(() async {
          PaytmResponse paytmResponse =
              PaytmResponse.fromJson(Map<String, dynamic>.from(value as Map));
          var response =
              await PaytmResponseViewModel().postPaytmResponse(paytmResponse);
          print(response);
          print(value.toString());
          print(value.toString());
          print(paytmResponse.CURRENCY);
          result = value.toString();
        });
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            result = onError.message.toString() +
                " \n  " +
                onError.details.toString();
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      result = err.toString();
    }
  }
}
