import '/screens/wallet_screen/view/wallet_screen_controller.dart';
import '/widgets/OkButton.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '/../../../utils/ui_utils.dart';

class AddMoneyDialogBox extends StatefulWidget {
  const AddMoneyDialogBox(
      {super.key, required this.isSuccessful, required this.amount});

  final bool isSuccessful;
  final int amount;

  @override
  State<AddMoneyDialogBox> createState() => _AddMoneyDialogBoxState();
}

class _AddMoneyDialogBoxState extends State<AddMoneyDialogBox> {
  String time = '';
  String date = '';

  String monthConverter(int month) {
    switch (month) {
      case 10:
        return 'Oct';
      case 1:
        return 'JAN';
      case 2:
        return 'FEB';
      case 3:
        return 'MAR';
      case 4:
        return 'APR';
      case 5:
        return 'MAY';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AUG';
      case 9:
        return 'SEP';
      case 11:
        return 'NOV';
      case 12:
        return 'DEC';
      default:
        return 'NA';
    }
  }

  getDate() {
    var month = DateTime.now().month;
    var monthName = monthConverter(month);
    var dayNumber = DateTime.now().day;
    date = "${dayNumber}th $monthName,2022";
  }

  getTime() {
    String minute;
    if (DateTime.now().minute < 10) {
      minute = "0${DateTime.now().minute.toString()}";
    } else {
      minute = DateTime.now().minute.toString();
    }
    time = "${DateTime.now().hour}:$minute";
  }

  @override
  void initState() {
    getDate();
    getTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UIUtills().updateScreenDimesion(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFFFFFFF),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(0, 2),
              blurRadius: 3,
            )
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: UIUtills().getProportionalHeight(height: 642.00),
        child: Column(
          children: [
            SizedBox(height: UIUtills().getProportionalHeight(height: 19.00)),
            widget.isSuccessful
                ? SvgPicture.asset(
                    'assets/images/greenTick.svg',
                    width: UIUtills().getProportionalWidth(width: 61.00),
                    height: 61.00,
                  )
                : SvgPicture.asset(
                    'assets/images/redCross.svg',
                    width: UIUtills().getProportionalWidth(width: 61.00),
                    height: 61.00,
                  ),
            SizedBox(height: UIUtills().getProportionalHeight(height: 19.00)),
            widget.isSuccessful
                ? Text(
                    'Success',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w800,
                        fontSize: UIUtills().getProportionalWidth(width: 32.00),
                        color: const Color(0xFF8F98FF),
                        letterSpacing: -0.41),
                  )
                : Text(
                    'Failed',
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w800,
                        fontSize: UIUtills().getProportionalWidth(width: 32.00),
                        color: const Color(0xFF8F98FF),
                        letterSpacing: -0.41),
                  ),
            SizedBox(height: UIUtills().getProportionalHeight(height: 29.00)),
            widget.isSuccessful
                ? Container(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            UIUtills().getProportionalWidth(width: 53.00)),
                    child: Text(
                      'Money has been successfully added to your wallet',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color.fromRGBO(130, 130, 130, 1),
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            UIUtills().getProportionalWidth(width: 53.00)),
                    child: Text(
                      'Money has not been added to your wallet',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color.fromRGBO(130, 130, 130, 1),
                      ),
                    ),
                  ),
            SizedBox(height: UIUtills().getProportionalHeight(height: 42.00)),
            DottedLine(
              dashGapLength: UIUtills().getProportionalWidth(width: 8.00),
              lineThickness: UIUtills().getProportionalHeight(height: 1.00),
              dashLength: UIUtills().getProportionalWidth(width: 8.00),
              lineLength: UIUtills().getProportionalWidth(width: 298.00),
              dashColor: const Color(0xFF929292),
            ),
            SizedBox(height: UIUtills().getProportionalHeight(height: 35.00)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: UIUtills().getProportionalWidth(width: 60.00),
                ),
                Text(
                  'Time',
                  style: GoogleFonts.roboto(
                      color: const Color.fromRGBO(130, 130, 130, 1),
                      fontSize: UIUtills().getProportionalWidth(width: 20.00),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.41),
                ),
                SizedBox(
                  width: UIUtills().getProportionalWidth(width: 41.00),
                ),
                Text(
                  time,
                  style: GoogleFonts.roboto(
                      color: const Color.fromRGBO(65, 65, 65, 1),
                      fontSize: UIUtills().getProportionalWidth(width: 24.00),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.41),
                ),
              ],
            ),
            SizedBox(height: UIUtills().getProportionalHeight(height: 35.00)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: UIUtills().getProportionalWidth(width: 60.00),
                ),
                Text(
                  'Date',
                  style: GoogleFonts.roboto(
                      color: const Color.fromRGBO(130, 130, 130, 1),
                      fontSize: UIUtills().getProportionalWidth(width: 20.00),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.41),
                ),
                SizedBox(
                  width: UIUtills().getProportionalWidth(width: 43.00),
                ),
                Text(
                  date,
                  style: GoogleFonts.roboto(
                      color: const Color.fromRGBO(65, 65, 65, 1),
                      fontSize: UIUtills().getProportionalWidth(width: 24.00),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.41),
                ),
              ],
            ),
            SizedBox(height: UIUtills().getProportionalHeight(height: 35.00)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.amber,
                  child: SizedBox(
                    width: UIUtills().getProportionalWidth(width: 60.00),
                  ),
                ),
                Text(
                  'Amount',
                  style: GoogleFonts.roboto(
                      color: const Color.fromRGBO(130, 130, 130, 1),
                      fontSize: UIUtills().getProportionalWidth(width: 20.00),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.41),
                ),
                SizedBox(
                  width: UIUtills().getProportionalWidth(width: 17.00),
                ),
                Text(
                  '₹ ${widget.amount}',
                  style: GoogleFonts.roboto(
                      color: const Color.fromRGBO(65, 65, 65, 1),
                      fontSize: UIUtills().getProportionalWidth(width: 24.00),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.41),
                ),
              ],
            ),
            SizedBox(height: UIUtills().getProportionalHeight(height: 34.00)),
            widget.isSuccessful
                ? Text(
                    'Sorry for the inconvenience',
                    style: GoogleFonts.roboto(
                        color: const Color(0xFFFFFFFF),
                        fontSize: UIUtills().getProportionalWidth(width: 16.00),
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.41),
                  )
                : Text(
                    'Sorry for the inconvenience',
                    style: GoogleFonts.roboto(
                        color: const Color(0xFF828282),
                        fontSize: UIUtills().getProportionalWidth(width: 16.00),
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.41),
                  ),
            SizedBox(height: UIUtills().getProportionalHeight(height: 34.00)),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  // FocusScopeNode currentFocus = FocusScope.of(context);
                  // if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  //   currentFocus.focusedChild?.unfocus();
                  // }
                  // Navigator.pop(context);
                  // PersistentNavBarNavigator.pushNewScreen(context,
                  //     screen: const WalletScreen(), withNavBar: true);
                  WalletScreenController.returnToWalletScreen.notifyListeners();
                },
                child: const OkButton()),
            SizedBox(height: UIUtills().getProportionalHeight(height: 30.00))
          ],
        ),
      ),
    );
  }
}
