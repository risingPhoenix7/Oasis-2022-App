import '/utils/ui_utils.dart';
import '/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '/../../provider/user_details_viewmodel.dart';
import '../view_model/wallet_viewmodel.dart';

class QRCodeDialogBox extends StatefulWidget {
  QRCodeDialogBox({super.key, required this.qrCode});

  String qrCode;

  @override
  State<QRCodeDialogBox> createState() => _QRCodeDialogBoxState();
}

class _QRCodeDialogBoxState extends State<QRCodeDialogBox> {
  String qrCode = '';
  late ValueNotifier<bool> isLoadingQrCode = ValueNotifier(false);

  @override
  void initState() {
    qrCode = widget.qrCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: const Color(0xFFFAFAFF),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFAFAFF),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 4),
              blurRadius: 4,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        width: UIUtills().getProportionalWidth(width: 408.00),
        height: UIUtills().getProportionalHeight(height: 602.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: UIUtills().getProportionalHeight(height: 48.00)),
            Text(
              'Scan this QR code to make payments',
              // textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                  color: const Color(0xFF818181),
                  fontSize: UIUtills().getProportionalWidth(width: 16.00),
                  fontWeight: FontWeight.w500,
                  letterSpacing: UIUtills().getProportionalWidth(width: -0.41)),
            ),
            SizedBox(height: UIUtills().getProportionalHeight(height: 38.00)),
            ValueListenableBuilder(
              valueListenable: isLoadingQrCode,
              builder: (context, bool value, child) {
                if (isLoadingQrCode.value) {
                  return SizedBox(
                      height: UIUtills().getProportionalWidth(width: 268),
                      width: UIUtills().getProportionalWidth(width: 268),
                      child: Loader());
                } else {
                  return QrImage(
                      size: UIUtills().getProportionalWidth(width: 268),
                      foregroundColor: Colors.black,
                      data: qrCode);
                }
              },
            ),
            SizedBox(height: UIUtills().getProportionalHeight(height: 32.00)),
            SvgPicture.asset('assets/images/exclamation_mark.svg'),
            SizedBox(height: UIUtills().getProportionalHeight(height: 12.00)),
            SizedBox(
              width: UIUtills().getProportionalWidth(width: 322.00),
              child: Text(
                'This is a single use QR code only for you. Get a new QR code everytime you refresh.',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    color: const Color(0xFF818181),
                    fontSize: UIUtills().getProportionalWidth(width: 16.00),
                    fontWeight: FontWeight.w500,
                    letterSpacing:
                        UIUtills().getProportionalWidth(width: -0.41)),
              ),
            ),
            SizedBox(height: UIUtills().getProportionalHeight(height: 24.00)),
            GestureDetector(
              onTap: () async {
                isLoadingQrCode.value = true;
                String tempQrCode = await WalletViewModel().refreshQrCode(
                    int.parse(UserDetailsViewModel.userDetails.userID!));
                setState(() {
                  qrCode = tempQrCode;
                  isLoadingQrCode.value = false;
                });
              },
              child: Container(
                width: UIUtills().getProportionalWidth(width: 205.00),
                height: UIUtills().getProportionalHeight(height: 51.00),
                //padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      offset: Offset(0, 2),
                      blurRadius: 3,
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(0, 0, 0, 1),
                      Color.fromRGBO(45, 45, 45, 1)
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    'Refresh',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: UIUtills().getProportionalWidth(width: 24.00),
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
