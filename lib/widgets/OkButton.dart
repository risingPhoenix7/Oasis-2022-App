import '../utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OkButton extends StatelessWidget {
  const OkButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UIUtills().getProportionalWidth(width: 258.00),
      height: UIUtills().getProportionalHeight(height: 59.00),
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
          colors: [Color.fromRGBO(0, 0, 0, 1), Color.fromRGBO(45, 45, 45, 1)],
        ),
      ),
      child: Center(
        child: Text(
          'Ok',
          style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: UIUtills().getProportionalWidth(width: 24.00),
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
