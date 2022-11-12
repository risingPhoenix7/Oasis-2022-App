import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/home.dart';
import 'package:oasis_2022/screens/wallet_screen/view/wallet_screen.dart';

class UpdatedAddMoneyDialogBox extends StatefulWidget {
  const UpdatedAddMoneyDialogBox({super.key, required this.isSuccessful});
  final bool isSuccessful;
  @override
  State<UpdatedAddMoneyDialogBox> createState() =>
      _UpdatedAddMoneyDialogBoxState();
}

class _UpdatedAddMoneyDialogBoxState extends State<UpdatedAddMoneyDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 32.h,
          left: 30.w,
          right: 30.w,
          bottom: 235.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const HomeScreen()),
                      (route) => false,
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/cross_icon.svg',
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 248.h),
                widget.isSuccessful
                    ? SvgPicture.asset(
                        'assets/images/moneyaddedsuccess.svg',
                        height: 177.h,
                        width: 222.w,
                        alignment: Alignment.center,
                      )
                    : SvgPicture.asset(
                        'assets/images/MoneyAddedfailure.svg',
                        height: 177.h,
                        width: 222.w,
                        alignment: Alignment.center,
                      ),
                SizedBox(height: 44.h),
                widget.isSuccessful
                    ? Text(
                        'Money Added Successfully.',
                        textScaleFactor: 1.0,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: Color.fromRGBO(255, 255, 255, 0.8)),
                      )
                    : Text(
                        'Something went wrong.',
                        textScaleFactor: 1.0,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: Color.fromRGBO(255, 255, 255, 0.8)),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
