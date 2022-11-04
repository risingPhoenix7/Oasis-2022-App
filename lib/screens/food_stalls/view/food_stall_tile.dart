import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodStallTile extends StatelessWidget {
  FoodStallTile({Key? key, required this.image, required this.foodStallName})
      : super(key: key);
  String image;
  String foodStallName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(116, 126, 241, 0.15),
            blurRadius: 8,
            offset: Offset(0, 4))
      ]),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image,
                height: UIUtills().getProportionalHeight(height: 180),
              )),
          Container(
            width: UIUtills().getProportionalWidth(width: 184),
            height: UIUtills().getProportionalHeight(height: 180),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(colors: <Color>[
                  Color.fromRGBO(26, 25, 25, 0.675),
                  Color.fromRGBO(33, 33, 33, 0)
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 104, 16, 19),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                foodStallName,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
