import '/screens/matches/repository/model/roundData.dart';
import '/utils/bosm_text_styles.dart';
import '/utils/common_functions.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingMultipleCollege extends StatelessWidget {
  UpcomingMultipleCollege({Key? key, required this.roundData})
      : super(key: key);
  final RoundData roundData;
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    List<String> collegeAndplayerList = <String>[];
    {
      if (roundData.team1_college_name != null &&
          roundData.team1_college_name!.isNotEmpty) {
        if (roundData.part1 == null || roundData.part1!.isEmpty) {
          collegeAndplayerList.add(roundData.team1_college_name!);
        } else {
          collegeAndplayerList.add(
              roundData.part1! + ' (' + roundData.team1_college_name! + ')');
        }
      }
      if (roundData.team2_college_name != null &&
          roundData.team2_college_name!.isNotEmpty) {
        if (roundData.part2 == null || roundData.part2!.isEmpty) {
          collegeAndplayerList.add(roundData.team2_college_name!);
        } else {
          collegeAndplayerList.add(
              roundData.part2! + ' (' + roundData.team2_college_name! + ')');
        }
      }
      if (roundData.team3_college_name != null &&
          roundData.team3_college_name!.isNotEmpty) {
        if (roundData.part3 == null || roundData.part3!.isEmpty) {
          collegeAndplayerList.add(roundData.team3_college_name!);
        } else {
          collegeAndplayerList.add(
              roundData.part3! + ' (' + roundData.team3_college_name! + ')');
        }
      }
      if (roundData.team4_college_name != null &&
          roundData.team4_college_name!.isNotEmpty) {
        if (roundData.part4 == null || roundData.part4!.isEmpty) {
          collegeAndplayerList.add(roundData.team4_college_name!);
        } else {
          collegeAndplayerList.add(
              roundData.part4! + ' (' + roundData.team4_college_name! + ')');
        }
      }
      if (roundData.team5_college_name != null &&
          roundData.team5_college_name!.isNotEmpty) {
        if (roundData.part5 == null || roundData.part5!.isEmpty) {
          collegeAndplayerList.add(roundData.team5_college_name!);
        } else {
          collegeAndplayerList.add(
              roundData.part5! + ' (' + roundData.team5_college_name! + ')');
        }
      }
      if (roundData.team6_college_name != null &&
          roundData.team6_college_name!.isNotEmpty) {
        if (roundData.part6 == null || roundData.part6!.isEmpty) {
          collegeAndplayerList.add(roundData.team6_college_name!);
        } else {
          collegeAndplayerList.add(
              roundData.part6! + ' (' + roundData.team6_college_name! + ')');
        }
      }
      if (roundData.team7_college_name != null &&
          roundData.team7_college_name!.isNotEmpty) {
        if (roundData.part7 == null || roundData.part7!.isEmpty) {
          collegeAndplayerList.add(roundData.team7_college_name!);
        } else {
          collegeAndplayerList.add(
              roundData.part7! + ' (' + roundData.team7_college_name! + ')');
        }
      }
      if (roundData.team8_college_name != null &&
          roundData.team8_college_name!.isNotEmpty) {
        if (roundData.part8 == null || roundData.part8!.isEmpty) {
          collegeAndplayerList.add(roundData.team8_college_name!);
        } else {
          collegeAndplayerList.add(
              roundData.part8! + ' (' + roundData.team8_college_name! + ')');
        }
      }
    }
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
            height: UIUtills().getProportionalHeight(
                height: 100 + 220 * collegeAndplayerList.length / 8),
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
                  width: UIUtills().getProportionalWidth(width: 284),
                  child: Divider(
                    // indent: 2,
                    // endIndent: 2,
                    height: 20,
                    thickness: 1,
                    color: Color(0xFFE2E2E2),
                  ),
                ),
                SizedBox(
                    height: UIUtills().getProportionalHeight(
                        height: 220 * collegeAndplayerList.length / 8),
                    child: Column(
                      children: List.generate(
                          collegeAndplayerList.length,
                          (index) => Center(
                                child: Text(
                                  collegeAndplayerList[index],
                                  maxLines: 1,
                                  style: BosmTextStyles.poppinsRegular.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: UIUtills()
                                          .getProportionalWidth(width: 16)),
                                ),
                              )),
                    ))
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
