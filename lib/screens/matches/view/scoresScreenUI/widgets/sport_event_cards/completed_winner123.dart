import '/screens/matches/repository/model/roundData.dart';
import '/utils/common_functions.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedWinner123 extends StatelessWidget {
  CompletedWinner123({Key? key, required this.roundData}) : super(key: key);
  final RoundData roundData;
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    date = CommonFunctions.timeStampConverter(roundData.timestamp);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(8.00, 10.00, 0.00, 0.00),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.8,
                color: const Color.fromRGBO(218, 218, 218, 0.5),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(157, 141, 255, 0.15),
                  offset: Offset(0, 4),
                  blurRadius: 6.00,
                ),
              ],
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(
                UIUtills().getProportionalWidth(width: 12.00),
              ),
            ),
            width: UIUtills().getProportionalWidth(width: 380.00),
            height: UIUtills().getProportionalHeight(height: 146),
            child: Column(
              children: [
                SizedBox(
                  height: UIUtills().getProportionalHeight(height: 16.00),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      roundData.round_type ?? 'NA',
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize:
                                UIUtills().getProportionalWidth(width: 20.00),
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      width: UIUtills().getProportionalWidth(width: 10.67),
                    ),
                    Text(
                      (roundData.round_name == '' ||
                              roundData.round_name == null)
                          ? ''
                          : '• ${roundData.round_name}',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize:
                                UIUtills().getProportionalWidth(width: 16.00),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFA0A0A0)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: UIUtills().getProportionalHeight(height: 8.00),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/locationIcon.svg',
                          width: UIUtills().getProportionalWidth(width: 8.02),
                          height:
                              UIUtills().getProportionalHeight(height: 10.93),
                        ),
                        Text(
                          roundData.venue_name != null
                              ? ' ${roundData.venue_name}'
                              : 'NA',
                          style: GoogleFonts.poppins(
                            fontSize:
                                UIUtills().getProportionalWidth(width: 14.00),
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(116, 126, 241, 1),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: UIUtills().getProportionalWidth(width: 64.00),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/clockIcon.svg',
                          width: UIUtills().getProportionalWidth(width: 12.03),
                          height:
                              UIUtills().getProportionalHeight(height: 12.03),
                        ),
                        Text(
                          CommonFunctions.getCorrectTimeString(date!),
                          style: GoogleFonts.poppins(
                            fontSize:
                                UIUtills().getProportionalWidth(width: 14.00),
                            fontWeight: FontWeight.w500,
                            color: const Color.fromRGBO(116, 126, 241, 1),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: UIUtills().getProportionalHeight(height: 8.00),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image(
                          image: const AssetImage(
                              'assets/images/silver_medal.png'),
                          width: UIUtills().getProportionalWidth(width: 25.00),
                        ),
                        SizedBox(
                          height:
                              UIUtills().getProportionalHeight(height: 6.00),
                        ),
                        Text(
                          roundData.winner2 ?? 'NA',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize:
                                  UIUtills().getProportionalWidth(width: 11.00),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: UIUtills().getProportionalWidth(width: 32.00),
                    ),
                    Column(
                      children: [
                        Image(
                          image:
                              const AssetImage('assets/images/gold_medal.png'),
                          width: UIUtills().getProportionalWidth(width: 35.00),
                        ),
                        SizedBox(
                          height:
                              UIUtills().getProportionalHeight(height: 7.00),
                        ),
                        Text(
                          roundData.winner1 ?? 'NA',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize:
                                  UIUtills().getProportionalWidth(width: 11.00),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: UIUtills().getProportionalWidth(width: 32.00),
                    ),
                    Column(
                      children: [
                        Image(
                          image: const AssetImage(
                              'assets/images/bronze_medal.png'),
                          width: UIUtills().getProportionalWidth(width: 25.00),
                        ),
                        SizedBox(
                          height:
                              UIUtills().getProportionalHeight(height: 6.00),
                        ),
                        Text(
                          roundData.winner3 ?? 'NA',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize:
                                  UIUtills().getProportionalWidth(width: 11.00),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Image(
            image: const AssetImage('assets/images/scores_UI_element.png'),
            width: UIUtills().getProportionalWidth(width: 53.00),
            height: UIUtills().getProportionalHeight(height: 47.00),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.fromLTRB(11.00, 5.00, 0, 0),
                child: Text(
                  date!.day.toString(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: UIUtills().getProportionalWidth(width: 14.00),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.fromLTRB(10.00, 0, 0, 0),
                child: Text(
                  CommonFunctions.monthConverter(date!.month),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: UIUtills().getProportionalWidth(width: 11.00),
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
