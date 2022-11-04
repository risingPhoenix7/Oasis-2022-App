import '/screens/quiz/view/quizUI.dart';
import '/screens/quiz/view_model/questions_view_model.dart';
import '/screens/quiz/view_model/storage.dart';
import '/widgets/loader.dart';
import '/widgets/quiz_appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/ui_utils.dart';
import '../repo/model/get_questions_model.dart';
import '../repo/model/get_rules_model.dart';

class RoundScreen extends StatefulWidget {
  const RoundScreen({super.key});

  @override
  State<RoundScreen> createState() => _RoundScreenState();
}

class _RoundScreenState extends State<RoundScreen> {
  final SecureStorage secureStorage = SecureStorage();
  bool noRoundLeft = false;
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  Questions questionList = Questions();
  Rules rulesList = Rules();
  int roundNumber = 0;
  int questionNumber = 0;

  @override
  void initState() {
    getRules();
    super.initState();
  }

  Future<void> getRules() async {
    questionNumber = await QuizScreenViewModel().getProgress();
    roundNumber = QuizScreenViewModel().getRoundNumber(questionNumber);
    rulesList = await QuizScreenViewModel().getRuleslist();
    questionList = await QuizScreenViewModel().getQuestionslist();
    isLoading.value = false;
    if ((questionNumber! ?? 1) > questionList.active_questions!.length) {
      noRoundLeft = true;
    }
  }

  String? getString() {
    List<String?> list = rulesList.rounds![(roundNumber ?? 1) - 1].rules;
    var stringList = list.join(" ");
    return stringList;
  }

  @override
  Widget build(BuildContext context) {
    getRules();
    print("round number is = $roundNumber");
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: QuizAppBar(
            title: "Quiz",
            isactionButtonRequired: true,
            isBackButtonRequired: false),
      ),
      body: ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (context, value, widge) {
            if (isLoading.value) {
              return const Center(child: Loader());
            } else {
              return noRoundLeft
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/images/no_rounds.svg"),
                          Text(
                            "No more quiz at the moment",
                            style: GoogleFonts.roboto(
                                fontSize:
                                    UIUtills().getProportionalWidth(width: 24),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFB9B8B8)),
                          )
                        ],
                      ),
                    )
                  : ListView(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                height: UIUtills()
                                    .getProportionalHeight(height: 38.00)),
                            Text(
                              'ROUND ${rulesList.rounds![(roundNumber ?? 1) - 1].round_no}',
                              style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: UIUtills()
                                      .getProportionalWidth(width: 24.00),
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: UIUtills()
                                      .getProportionalWidth(width: -0.41)),
                            ),
                            SizedBox(
                                height: UIUtills()
                                    .getProportionalHeight(height: 39.00)),
                            Image.asset(
                              'assets/images/rounds.png',
                              height:
                                  UIUtills().getProportionalHeight(height: 286),
                              width:
                                  UIUtills().getProportionalWidth(width: 338),
                            ),
                            SizedBox(
                                height: UIUtills()
                                    .getProportionalHeight(height: 39.00)),
                            Container(
                              width: UIUtills()
                                  .getProportionalWidth(width: 213.00),
                              child: Text(
                                '${rulesList.rounds![(roundNumber ?? 1) - 1].round_name}',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                    color: const Color(0xFF373232),
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 32.00),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: UIUtills()
                                        .getProportionalWidth(width: -0.41)),
                              ),
                            ),
                            SizedBox(
                                height: UIUtills()
                                    .getProportionalHeight(height: 38.00)),
                            Text(
                              'Rules',
                              style: GoogleFonts.roboto(
                                  color: const Color(0xFF747EF1),
                                  fontSize: UIUtills()
                                      .getProportionalWidth(width: 24.00),
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: UIUtills()
                                      .getProportionalWidth(width: -0.41)),
                            ),
                            SizedBox(
                                height: UIUtills()
                                    .getProportionalHeight(height: 22.00)),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Text(
                                getString()!,
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFF373232),
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16.00),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: UIUtills()
                                        .getProportionalWidth(width: -0.41)),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            SizedBox(
                                height: UIUtills()
                                    .getProportionalHeight(height: 22.00)),
                            GestureDetector(
                              onTap: () async {
                                if (!mounted) {}
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            (QuizScreenSingleSelect(
                                              questionList: questionList,
                                              rulesList: rulesList,
                                              round: (roundNumber ?? 1),
                                              questionNumber: questionNumber,
                                            ))));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    // alignment: Alignment.bottomCenter,
                                    width: double.infinity,
                                    height: UIUtills()
                                        .getProportionalHeight(height: 60.00),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: UIUtills()
                                            .getProportionalWidth(
                                                width: 70.00)),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(0, 0, 0, 1),
                                          Color.fromRGBO(45, 45, 45, 1)
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
                                        UIUtills()
                                            .getProportionalWidth(width: 15.00),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Start',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                fontSize: UIUtills()
                                                    .getProportionalWidth(
                                                        width: 20.00),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 33.00))
                      ],
                    );
            }
          }),
    );
  }

  //TODO: DONT DELETE ELSE PRABHAS CRI

  int round(String? finalRound) {
    if (finalRound == '1') {
      return 1;
    } else if (finalRound == '2') {
      return 2;
    } else if (finalRound == '3') {
      return 3;
    } else if (finalRound == '4') {
      return 4;
    } else if (finalRound == '5') {
      return 5;
    } else if (finalRound == '6') {
      return 6;
    } else if (finalRound == '7') {
      return 7;
    } else if (finalRound == '8') {
      return 8;
    } else if (finalRound == '9') {
      return 9;
    } else
      return 0;
  }
}
