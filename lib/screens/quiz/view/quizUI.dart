// import '/screens/quiz/view/quiz_screen_controller.dart';
// import '/screens/quiz/view/round.dart';
// import '/screens/quiz/view_model/storage.dart';
// import '/utils/ui_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../widgets/app_bar.dart';
// import '../repo/model/get_questions_model.dart';
// import '../repo/model/get_rules_model.dart';
// import '../view_model/questions_view_model.dart';
//
// class QuizScreenSingleSelect extends StatefulWidget {
//   QuizScreenSingleSelect(
//       {super.key,
//       required this.questionList,
//       required this.rulesList,
//       required this.round,
//       required this.questionNumber});
//
//   Questions questionList;
//   Rules rulesList;
//   int round;
//   int questionNumber;
//
//   @override
//   State<QuizScreenSingleSelect> createState() => _QuizScreenSingleSelectState();
// }
//
// class _QuizScreenSingleSelectState extends State<QuizScreenSingleSelect>
//     with TickerProviderStateMixin {
//   final SecureStorage secureStorage = SecureStorage();
//   var optionArray = [0, 0, 0, 0];
//   List<int?> optionIds = [];
//   int helper = 0;
//   int time = 0;
//   late AnimationController controller;
//   Map<int, String> optionMap = {};
//   List<String> optionText = [];
//   int displayQuestionNumber = 0;
//   String questionText = "";
//   String imageLink = "";
//   int questionNumber = 0;
//
//   @override
//   void initState() {
//     questionNumber = widget.questionNumber;
//     QuizScreenController.newQuestion.addListener(() {
//       setState(() {
//         try {
//           displayQuestionNumber =
//               QuizScreenViewModel().getQuestionNumber((questionNumber ?? 1));
//           time = QuizScreenViewModel()
//               .getQuestionTime((questionNumber ?? 1), widget.questionList)!;
//           optionMap = QuizScreenViewModel()
//               .getQuestionOption((questionNumber ?? 1), widget.questionList);
//           optionText = getOptionText(optionMap);
//           questionText = QuizScreenViewModel()
//               .getQuestionText((questionNumber ?? 1), widget.questionList)!;
//           imageLink = QuizScreenViewModel()
//               .getQuestionImage((questionNumber ?? 1), widget.questionList)!;
//         } catch (e) {
//           print(e);
//         }
//         controller = AnimationController(
//             vsync: this, duration: Duration(seconds: time))
//           ..addListener(() async {
//             if (controller.isCompleted) {
//               if (displayQuestionNumber >= 5) {
//                 optionIds = [];
//                 optionArray = [0, 0, 0, 0];
//                 questionNumber = await QuizScreenViewModel().getProgress();
//                 QuizScreenController.newQuestion.value++;
//                 if (!mounted) {}
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => (RoundScreen())));
//               } else {
//                 optionIds = [];
//                 optionArray = [0, 0, 0, 0];
//                 await QuizScreenViewModel().postAnswers(questionNumber, [1]);
//                 questionNumber = await QuizScreenViewModel().getProgress();
//                 QuizScreenController.newQuestion.value++;
//               }
//             }
//             setState(() {});
//           });
//         controller.repeat();
//         controller.forward();
//         QuizScreenController.newQuestion.addListener(() {
//           rebuildAnimationController();
//         });
//       });
//     });
//     displayQuestionNumber =
//         QuizScreenViewModel().getQuestionNumber((questionNumber ?? 1));
//     print("final question = ${questionNumber}");
//     time = QuizScreenViewModel()
//         .getQuestionTime((questionNumber ?? 1), widget.questionList)!;
//     controller =
//         AnimationController(vsync: this, duration: Duration(seconds: time))
//           ..addListener(() async {
//             if (controller.isCompleted) {
//               if (displayQuestionNumber >= 5) {
//                 optionIds = [];
//                 optionArray = [0, 0, 0, 0];
//                 await QuizScreenViewModel().postAnswers(questionNumber, [1]);
//                 questionNumber = await QuizScreenViewModel().getProgress();
//                 QuizScreenController.newQuestion.value++;
//                 if (!mounted) {}
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => (RoundScreen())));
//               } else {
//                 optionIds = [];
//                 optionArray = [0, 0, 0, 0];
//                 await QuizScreenViewModel().postAnswers(questionNumber, [1]);
//                 questionNumber = await QuizScreenViewModel().getProgress();
//                 QuizScreenController.newQuestion.value++;
//               }
//             }
//             setState(() {});
//           });
//     controller.repeat();
//     controller.forward();
//     QuizScreenController.newQuestion.addListener(() {
//       rebuildAnimationController();
//     });
//     optionMap = QuizScreenViewModel()
//         .getQuestionOption((questionNumber ?? 1), widget.questionList);
//     optionText = getOptionText(optionMap);
//     questionText = QuizScreenViewModel()
//         .getQuestionText((questionNumber ?? 1), widget.questionList)!;
//     imageLink = QuizScreenViewModel()
//         .getQuestionImage((questionNumber ?? 1), widget.questionList)!;
//     super.initState();
//   }
//
//   rebuildAnimationController() {
//     setState(() {
//       controller =
//           AnimationController(vsync: this, duration: Duration(seconds: time))
//             ..addListener(() async {
//               if (controller.isCompleted) {
//                 if (displayQuestionNumber >= 5) {
//                   optionIds = [];
//                   optionArray = [0, 0, 0, 0];
//                   await QuizScreenViewModel().postAnswers(questionNumber, [1]);
//                   questionNumber = await QuizScreenViewModel().getProgress();
//                   QuizScreenController.newQuestion.value++;
//                   if (!mounted) {}
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => (RoundScreen())));
//                 } else {
//                   optionIds = [];
//                   optionArray = [0, 0, 0, 0];
//                   await QuizScreenViewModel().postAnswers(questionNumber, [1]);
//                   questionNumber = await QuizScreenViewModel().getProgress();
//                   QuizScreenController.newQuestion.value++;
//                 }
//               }
//             });
//       controller.repeat();
//       controller.forward();
//     });
//   }
//
//   getOptionText(Map<int, String> optionMap) {
//     List<String> optionTextArray = [];
//     for (String i in optionMap.values) {
//       optionTextArray.add(i);
//     }
//     return optionTextArray;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color(0xFFFAFAFF),
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(kToolbarHeight),
//           child: CustomAppBar(
//               title: 'Round ${widget.round}',
//               isactionButtonRequired: false,
//               isBackButtonRequired: false),
//         ),
//         body: ListView(
//           children: [
//             SizedBox(height: UIUtills().getProportionalHeight(height: 20.00)),
//             Container(
//               margin: EdgeInsets.symmetric(
//                   horizontal: UIUtills().getProportionalWidth(width: 30.00)),
//               child: Stack(
//                 alignment: AlignmentDirectional.center,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: SizedBox(
//                       height: 28,
//                       width: double.infinity,
//                       child: RotatedBox(
//                         quarterTurns: 2,
//                         child: LinearProgressIndicator(
//                           valueColor:
//                               const AlwaysStoppedAnimation(Colors.white),
//                           backgroundColor: Colors.black,
//                           value: controller.value,
//                           semanticsLabel: 'Linear progress indicator',
//                         ),
//                       ),
//                     ),
//                   ),
//                   ((time - (controller.value * time)).toInt() > (time / 2) - 1)
//                       ? Text(
//                           (time - (controller.value * time)).toInt().toString(),
//                           style: const TextStyle(color: Colors.white),
//                         )
//                       : Text(
//                           (time - (controller.value * time)).toInt().toString(),
//                           style: const TextStyle(color: Colors.black),
//                         ),
//                   Container(
//                     padding: EdgeInsets.only(
//                         left: UIUtills().getProportionalWidth(width: 285.00),
//                         right: UIUtills().getProportionalWidth(width: 0.00)),
//                     child: SvgPicture.asset(
//                       'assets/images/quizClock.svg',
//                       width: UIUtills().getProportionalWidth(width: 13),
//                       height: UIUtills().getProportionalHeight(height: 15.17),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: UIUtills().getProportionalHeight(height: 24.00)),
//             Container(
//               width: UIUtills().getProportionalWidth(width: 388.00),
//               margin: EdgeInsets.symmetric(
//                 horizontal: UIUtills().getProportionalWidth(width: 20.00),
//               ),
//               decoration: BoxDecoration(
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color.fromRGBO(157, 141, 255, 0.15),
//                     offset: Offset(0, 2),
//                     blurRadius: 8.00,
//                   ),
//                 ],
//                 color: const Color.fromRGBO(255, 255, 255, 1),
//                 border: Border.all(
//                   width: 1.0,
//                   color: const Color.fromRGBO(218, 218, 218, 0.5),
//                 ),
//                 borderRadius: BorderRadius.circular(
//                   UIUtills().getProportionalWidth(width: 10.00),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(
//                       height: UIUtills().getProportionalHeight(height: 20.00)),
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: UIUtills().getProportionalWidth(width: 28.00),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.only(
//                               left:
//                                   UIUtills().getProportionalWidth(width: 6.00)),
//                           child: Text.rich(
//                             TextSpan(
//                               text:
//                                   "Question ${displayQuestionNumber.toString()}",
//                               style: GoogleFonts.roboto(
//                                   color: const Color(0xFF6D6D6D),
//                                   fontSize: UIUtills()
//                                       .getProportionalWidth(width: 24),
//                                   fontWeight: FontWeight.w700,
//                                   letterSpacing: UIUtills()
//                                       .getProportionalWidth(width: -0.41)),
//                               children: [
//                                 TextSpan(
//                                   text: "/5",
//                                   style: GoogleFonts.roboto(
//                                       color: const Color(0xFF555555),
//                                       fontSize: UIUtills()
//                                           .getProportionalWidth(width: 14),
//                                       fontWeight: FontWeight.w700,
//                                       letterSpacing: UIUtills()
//                                           .getProportionalWidth(width: -0.41)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         //SvgPicture.asset('assets/images/hintIconBulb.svg')
//                       ],
//                     ),
//                   ),
//
//                   //Image.network('${widget.questionList.active_questions![question.value-1].image_link}'),
//                   SizedBox(
//                       height: UIUtills().getProportionalHeight(height: 26.00)),
//                   Container(
//                       padding: EdgeInsets.symmetric(
//                           horizontal:
//                               UIUtills().getProportionalWidth(width: 38.00)),
//                       child: Column(
//                         children: [
//                           Text(
//                             questionText,
//                             style: GoogleFonts.roboto(
//                                 fontSize: UIUtills()
//                                     .getProportionalWidth(width: 20.00),
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: UIUtills()
//                                     .getProportionalWidth(width: -0.41)),
//                           ),
//                           (imageLink != 'a')
//                               ? Column(
//                                   children: [
//                                     SizedBox(
//                                         height: UIUtills()
//                                             .getProportionalHeight(
//                                                 height: 20.00)),
//                                     Image.network(imageLink),
//                                     SizedBox(
//                                         height: UIUtills()
//                                             .getProportionalHeight(
//                                                 height: 30.00)),
//                                   ],
//                                 )
//                               : SizedBox(
//                                   height: UIUtills()
//                                       .getProportionalHeight(height: 68.00)),
//                           (widget.round == 6)
//                               ? Column(
//                                   children: [
//                                     GestureDetector(
//                                         onTap: () {
//                                           print("round == 6");
//                                           if ((optionArray[0] +
//                                                       optionArray[1] +
//                                                       optionArray[2] +
//                                                       optionArray[3]) ==
//                                                   0 ||
//                                               (optionArray[0] +
//                                                       optionArray[1] +
//                                                       optionArray[2] +
//                                                       optionArray[3]) ==
//                                                   1) {
//                                             optionArray[0] =
//                                                 optionArray[0] == 0 ? 1 : 0;
//                                             setState(() {});
//                                           } else {
//                                             optionArray[0] = 0;
//                                             setState(() {});
//                                             print(
//                                                 'You can select 2 options at maximum');
//                                           }
//                                         },
//                                         child: optionArray[0] == 0
//                                             ? Container(
//                                                 decoration: BoxDecoration(
//                                                   color: const Color.fromRGBO(
//                                                       255, 255, 255, 1),
//                                                   border: Border.all(
//                                                     width: 1.0,
//                                                     color:
//                                                         const Color(0xFF9F9F9F),
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                     UIUtills()
//                                                         .getProportionalWidth(
//                                                             width: 8.00),
//                                                   ),
//                                                 ),
//                                                 width: UIUtills()
//                                                     .getProportionalWidth(
//                                                         width: 312.00),
//                                                 height: UIUtills()
//                                                     .getProportionalHeight(
//                                                         height: 66.00),
//                                                 child: Center(
//                                                   child: Text(
//                                                     optionText[0],
//                                                     textAlign: TextAlign.center,
//                                                     style: GoogleFonts.roboto(
//                                                         fontSize: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: 20.00),
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         letterSpacing: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: -0.41)),
//                                                   ),
//                                                 ),
//                                               )
//                                             : Container(
//                                                 decoration: BoxDecoration(
//                                                   boxShadow: const [],
//                                                   color:
//                                                       const Color(0xFF747EF1),
//                                                   border: Border.all(
//                                                     width: 1.0,
//                                                     color:
//                                                         const Color(0xFF9F9F9F),
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                     UIUtills()
//                                                         .getProportionalWidth(
//                                                             width: 8.00),
//                                                   ),
//                                                 ),
//                                                 width: UIUtills()
//                                                     .getProportionalWidth(
//                                                         width: 312.00),
//                                                 height: UIUtills()
//                                                     .getProportionalHeight(
//                                                         height: 66.00),
//                                                 child: Center(
//                                                   child: Text(
//                                                     optionText[0],
//                                                     textAlign: TextAlign.center,
//                                                     style: GoogleFonts.roboto(
//                                                         color: const Color(
//                                                             0xFFFFFFFF),
//                                                         fontSize: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: 20.00),
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         letterSpacing: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: -0.41)),
//                                                   ),
//                                                 ),
//                                               )),
//                                     SizedBox(
//                                         height: UIUtills()
//                                             .getProportionalHeight(
//                                                 height: 20.00)),
//                                     GestureDetector(
//                                         onTap: () {
//                                           if ((optionArray[0] +
//                                                       optionArray[1] +
//                                                       optionArray[2] +
//                                                       optionArray[3]) ==
//                                                   0 ||
//                                               (optionArray[0] +
//                                                       optionArray[1] +
//                                                       optionArray[2] +
//                                                       optionArray[3]) ==
//                                                   1) {
//                                             optionArray[1] =
//                                                 optionArray[1] == 0 ? 1 : 0;
//                                             setState(() {});
//                                           } else {
//                                             optionArray[1] = 0;
//                                             setState(() {});
//                                           }
//                                           print(
//                                               'You can select 2 options at maximum');
//                                         },
//                                         child: optionArray[1] == 0
//                                             ? Container(
//                                                 decoration: BoxDecoration(
//                                                   color: const Color.fromRGBO(
//                                                       255, 255, 255, 1),
//                                                   border: Border.all(
//                                                     width: 1.0,
//                                                     color:
//                                                         const Color(0xFF9F9F9F),
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                     UIUtills()
//                                                         .getProportionalWidth(
//                                                             width: 8.00),
//                                                   ),
//                                                 ),
//                                                 width: UIUtills()
//                                                     .getProportionalWidth(
//                                                         width: 312.00),
//                                                 height: UIUtills()
//                                                     .getProportionalHeight(
//                                                         height: 66.00),
//                                                 child: Center(
//                                                   child: Text(
//                                                     optionText[1],
//                                                     textAlign: TextAlign.center,
//                                                     style: GoogleFonts.roboto(
//                                                         fontSize: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: 20.00),
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         letterSpacing: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: -0.41)),
//                                                   ),
//                                                 ),
//                                               )
//                                             : Container(
//                                                 decoration: BoxDecoration(
//                                                   boxShadow: const [],
//                                                   color:
//                                                       const Color(0xFF747EF1),
//                                                   border: Border.all(
//                                                     width: 1.0,
//                                                     color:
//                                                         const Color(0xFF9F9F9F),
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                     UIUtills()
//                                                         .getProportionalWidth(
//                                                             width: 8.00),
//                                                   ),
//                                                 ),
//                                                 width: UIUtills()
//                                                     .getProportionalWidth(
//                                                         width: 312.00),
//                                                 height: UIUtills()
//                                                     .getProportionalHeight(
//                                                         height: 66.00),
//                                                 child: Center(
//                                                   child: Text(
//                                                     optionText[1],
//                                                     textAlign: TextAlign.center,
//                                                     style: GoogleFonts.roboto(
//                                                         color: const Color(
//                                                             0xFFFFFFFF),
//                                                         fontSize: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: 20.00),
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         letterSpacing: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: -0.41)),
//                                                   ),
//                                                 ),
//                                               )),
//                                     SizedBox(
//                                         height: UIUtills()
//                                             .getProportionalHeight(
//                                                 height: 20.00)),
//                                     GestureDetector(
//                                         onTap: () {
//                                           if ((optionArray[0] +
//                                                       optionArray[1] +
//                                                       optionArray[2] +
//                                                       optionArray[3]) ==
//                                                   0 ||
//                                               (optionArray[0] +
//                                                       optionArray[1] +
//                                                       optionArray[2] +
//                                                       optionArray[3]) ==
//                                                   1) {
//                                             optionArray[2] =
//                                                 optionArray[2] == 0 ? 1 : 0;
//                                             setState(() {});
//                                           } else {
//                                             optionArray[2] = 0;
//                                             setState(() {});
//                                             print(
//                                                 'You can select 2 options at maximum');
//                                           }
//                                         },
//                                         child: optionArray[2] == 0
//                                             ? Container(
//                                                 decoration: BoxDecoration(
//                                                   color: const Color.fromRGBO(
//                                                       255, 255, 255, 1),
//                                                   border: Border.all(
//                                                     width: 1.0,
//                                                     color:
//                                                         const Color(0xFF9F9F9F),
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                     UIUtills()
//                                                         .getProportionalWidth(
//                                                             width: 8.00),
//                                                   ),
//                                                 ),
//                                                 width: UIUtills()
//                                                     .getProportionalWidth(
//                                                         width: 312.00),
//                                                 height: UIUtills()
//                                                     .getProportionalHeight(
//                                                         height: 66.00),
//                                                 child: Center(
//                                                   child: Text(
//                                                     optionText[2],
//                                                     textAlign: TextAlign.center,
//                                                     style: GoogleFonts.roboto(
//                                                         fontSize: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: 20.00),
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         letterSpacing: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: -0.41)),
//                                                   ),
//                                                 ),
//                                               )
//                                             : Container(
//                                                 decoration: BoxDecoration(
//                                                   boxShadow: const [],
//                                                   color:
//                                                       const Color(0xFF747EF1),
//                                                   border: Border.all(
//                                                     width: 1.0,
//                                                     color:
//                                                         const Color(0xFF9F9F9F),
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                     UIUtills()
//                                                         .getProportionalWidth(
//                                                             width: 8.00),
//                                                   ),
//                                                 ),
//                                                 width: UIUtills()
//                                                     .getProportionalWidth(
//                                                         width: 312.00),
//                                                 height: UIUtills()
//                                                     .getProportionalHeight(
//                                                         height: 66.00),
//                                                 child: Center(
//                                                   child: Text(
//                                                     optionText[2],
//                                                     textAlign: TextAlign.center,
//                                                     style: GoogleFonts.roboto(
//                                                         color: const Color(
//                                                             0xFFFFFFFF),
//                                                         fontSize: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: 20.00),
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         letterSpacing: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: -0.41)),
//                                                   ),
//                                                 ),
//                                               )),
//                                     SizedBox(
//                                         height: UIUtills()
//                                             .getProportionalHeight(
//                                                 height: 20.00)),
//                                     GestureDetector(
//                                       onTap: () {
//                                         if ((optionArray[0] +
//                                                     optionArray[1] +
//                                                     optionArray[2] +
//                                                     optionArray[3]) ==
//                                                 0 ||
//                                             (optionArray[0] +
//                                                     optionArray[1] +
//                                                     optionArray[2] +
//                                                     optionArray[3]) ==
//                                                 1) {
//                                           optionArray[3] =
//                                               optionArray[3] == 0 ? 1 : 0;
//                                           setState(() {});
//                                         } else {
//                                           optionArray[3] = 0;
//                                           setState(() {});
//                                           print(
//                                               'You can select 2 options at maximum');
//                                         }
//                                       },
//                                       child: optionArray[3] == 0
//                                           ? Container(
//                                               decoration: BoxDecoration(
//                                                 color: const Color.fromRGBO(
//                                                     255, 255, 255, 1),
//                                                 border: Border.all(
//                                                   width: 1.0,
//                                                   color:
//                                                       const Color(0xFF9F9F9F),
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   UIUtills()
//                                                       .getProportionalWidth(
//                                                           width: 8.00),
//                                                 ),
//                                               ),
//                                               width: UIUtills()
//                                                   .getProportionalWidth(
//                                                       width: 312.00),
//                                               height: UIUtills()
//                                                   .getProportionalHeight(
//                                                       height: 66.00),
//                                               child: Center(
//                                                 child: Text(
//                                                   optionText[3],
//                                                   textAlign: TextAlign.center,
//                                                   style: GoogleFonts.roboto(
//                                                       fontSize: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: 20.00),
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       letterSpacing: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: -0.41)),
//                                                 ),
//                                               ),
//                                             )
//                                           : Container(
//                                               decoration: BoxDecoration(
//                                                 boxShadow: const [],
//                                                 color: const Color(0xFF747EF1),
//                                                 border: Border.all(
//                                                   width: 1.0,
//                                                   color:
//                                                       const Color(0xFF9F9F9F),
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   UIUtills()
//                                                       .getProportionalWidth(
//                                                           width: 8.00),
//                                                 ),
//                                               ),
//                                               width: UIUtills()
//                                                   .getProportionalWidth(
//                                                       width: 312.00),
//                                               height: UIUtills()
//                                                   .getProportionalHeight(
//                                                       height: 66.00),
//                                               child: Center(
//                                                 child: Text(
//                                                   optionText[3],
//                                                   textAlign: TextAlign.center,
//                                                   style: GoogleFonts.roboto(
//                                                       color: const Color(
//                                                           0xFFFFFFFF),
//                                                       fontSize: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: 20.00),
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       letterSpacing: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: -0.41)),
//                                                 ),
//                                               ),
//                                             ),
//                                     ),
//                                   ],
//                                 )
//                               : Column(
//                                   children: [
//                                     GestureDetector(
//                                         onTap: () {
//                                           optionArray = [1, 0, 0, 0];
//
//                                           setState(() {});
//                                         },
//                                         child: optionArray[0] == 0
//                                             ? Container(
//                                                 decoration: BoxDecoration(
//                                                   color: const Color.fromRGBO(
//                                                       255, 255, 255, 1),
//                                                   border: Border.all(
//                                                     width: 1.0,
//                                                     color:
//                                                         const Color(0xFF9F9F9F),
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                     UIUtills()
//                                                         .getProportionalWidth(
//                                                             width: 8.00),
//                                                   ),
//                                                 ),
//                                                 width: UIUtills()
//                                                     .getProportionalWidth(
//                                                         width: 312.00),
//                                                 height: UIUtills()
//                                                     .getProportionalHeight(
//                                                         height: 66.00),
//                                                 child: Center(
//                                                   child: Text(
//                                                     optionText[0],
//                                                     textAlign: TextAlign.center,
//                                                     style: GoogleFonts.roboto(
//                                                         fontSize: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: 20.00),
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         letterSpacing: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: -0.41)),
//                                                   ),
//                                                 ),
//                                               )
//                                             : Container(
//                                                 decoration: BoxDecoration(
//                                                   boxShadow: const [],
//                                                   color:
//                                                       const Color(0xFF747EF1),
//                                                   border: Border.all(
//                                                     width: 1.0,
//                                                     color:
//                                                         const Color(0xFF9F9F9F),
//                                                   ),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                     UIUtills()
//                                                         .getProportionalWidth(
//                                                             width: 8.00),
//                                                   ),
//                                                 ),
//                                                 width: UIUtills()
//                                                     .getProportionalWidth(
//                                                         width: 312.00),
//                                                 height: UIUtills()
//                                                     .getProportionalHeight(
//                                                         height: 66.00),
//                                                 child: Center(
//                                                   child: Text(
//                                                     optionText[0],
//                                                     textAlign: TextAlign.center,
//                                                     style: GoogleFonts.roboto(
//                                                         color: const Color(
//                                                             0xFFFFFFFF),
//                                                         fontSize: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: 20.00),
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                         letterSpacing: UIUtills()
//                                                             .getProportionalWidth(
//                                                                 width: -0.41)),
//                                                   ),
//                                                 ),
//                                               )),
//                                     SizedBox(
//                                         height: UIUtills()
//                                             .getProportionalHeight(
//                                                 height: 20.00)),
//                                     GestureDetector(
//                                       onTap: () {
//                                         optionArray = [0, 1, 0, 0];
//                                         setState(() {});
//                                       },
//                                       child: optionArray[1] == 0
//                                           ? Container(
//                                               decoration: BoxDecoration(
//                                                 color: const Color.fromRGBO(
//                                                     255, 255, 255, 1),
//                                                 border: Border.all(
//                                                   width: 1.0,
//                                                   color:
//                                                       const Color(0xFF9F9F9F),
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   UIUtills()
//                                                       .getProportionalWidth(
//                                                           width: 8.00),
//                                                 ),
//                                               ),
//                                               width: UIUtills()
//                                                   .getProportionalWidth(
//                                                       width: 312.00),
//                                               height: UIUtills()
//                                                   .getProportionalHeight(
//                                                       height: 66.00),
//                                               child: Center(
//                                                 child: Text(
//                                                   optionText[1],
//                                                   textAlign: TextAlign.center,
//                                                   style: GoogleFonts.roboto(
//                                                       fontSize: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: 20.00),
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       letterSpacing: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: -0.41)),
//                                                 ),
//                                               ),
//                                             )
//                                           : Container(
//                                               decoration: BoxDecoration(
//                                                 boxShadow: const [],
//                                                 color: const Color(0xFF747EF1),
//                                                 border: Border.all(
//                                                   width: 1.0,
//                                                   color:
//                                                       const Color(0xFF9F9F9F),
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   UIUtills()
//                                                       .getProportionalWidth(
//                                                           width: 8.00),
//                                                 ),
//                                               ),
//                                               width: UIUtills()
//                                                   .getProportionalWidth(
//                                                       width: 312.00),
//                                               height: UIUtills()
//                                                   .getProportionalHeight(
//                                                       height: 66.00),
//                                               child: Center(
//                                                 child: Text(
//                                                   optionText[1],
//                                                   style: GoogleFonts.roboto(
//                                                       color: const Color(
//                                                           0xFFFFFFFF),
//                                                       fontSize: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: 20.00),
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       letterSpacing: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: -0.41)),
//                                                 ),
//                                               ),
//                                             ),
//                                     ),
//                                     SizedBox(
//                                         height: UIUtills()
//                                             .getProportionalHeight(
//                                                 height: 20.00)),
//                                     GestureDetector(
//                                       onTap: () {
//                                         optionArray = [0, 0, 1, 0];
//
//                                         setState(() {});
//                                       },
//                                       child: optionArray[2] == 0
//                                           ? Container(
//                                               decoration: BoxDecoration(
//                                                 color: const Color.fromRGBO(
//                                                     255, 255, 255, 1),
//                                                 border: Border.all(
//                                                   width: 1.0,
//                                                   color:
//                                                       const Color(0xFF9F9F9F),
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   UIUtills()
//                                                       .getProportionalWidth(
//                                                           width: 8.00),
//                                                 ),
//                                               ),
//                                               width: UIUtills()
//                                                   .getProportionalWidth(
//                                                       width: 312.00),
//                                               height: UIUtills()
//                                                   .getProportionalHeight(
//                                                       height: 66.00),
//                                               child: Center(
//                                                 child: Text(
//                                                   optionText[2],
//                                                   style: GoogleFonts.roboto(
//                                                       fontSize: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: 20.00),
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       letterSpacing: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: -0.41)),
//                                                 ),
//                                               ),
//                                             )
//                                           : Container(
//                                               decoration: BoxDecoration(
//                                                 boxShadow: const [],
//                                                 color: const Color(0xFF747EF1),
//                                                 border: Border.all(
//                                                   width: 1.0,
//                                                   color:
//                                                       const Color(0xFF9F9F9F),
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   UIUtills()
//                                                       .getProportionalWidth(
//                                                           width: 8.00),
//                                                 ),
//                                               ),
//                                               width: UIUtills()
//                                                   .getProportionalWidth(
//                                                       width: 312.00),
//                                               height: UIUtills()
//                                                   .getProportionalHeight(
//                                                       height: 66.00),
//                                               child: Center(
//                                                 child: Text(
//                                                   optionText[2],
//                                                   style: GoogleFonts.roboto(
//                                                       color: const Color(
//                                                           0xFFFFFFFF),
//                                                       fontSize: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: 20.00),
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       letterSpacing: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: -0.41)),
//                                                 ),
//                                               ),
//                                             ),
//                                     ),
//                                     SizedBox(
//                                         height: UIUtills()
//                                             .getProportionalHeight(
//                                                 height: 20.00)),
//                                     GestureDetector(
//                                       onTap: () {
//                                         optionArray = [0, 0, 0, 1];
//
//                                         setState(() {});
//                                       },
//                                       child: optionArray[3] == 0
//                                           ? Container(
//                                               decoration: BoxDecoration(
//                                                 color: const Color.fromRGBO(
//                                                     255, 255, 255, 1),
//                                                 border: Border.all(
//                                                   width: 1.0,
//                                                   color:
//                                                       const Color(0xFF9F9F9F),
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   UIUtills()
//                                                       .getProportionalWidth(
//                                                           width: 8.00),
//                                                 ),
//                                               ),
//                                               width: UIUtills()
//                                                   .getProportionalWidth(
//                                                       width: 312.00),
//                                               height: UIUtills()
//                                                   .getProportionalHeight(
//                                                       height: 66.00),
//                                               child: Center(
//                                                 child: Text(
//                                                   optionText[3],
//                                                   style: GoogleFonts.roboto(
//                                                       fontSize: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: 20.00),
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       letterSpacing: UIUtills()
//                                                           .getProportionalWidth(
//                                                               width: -0.41)),
//                                                 ),
//                                               ),
//                                             )
//                                           : Container(
//                                               decoration: BoxDecoration(
//                                                 boxShadow: const [],
//                                                 color: const Color(0xFF747EF1),
//                                                 border: Border.all(
//                                                   width: 1.0,
//                                                   color:
//                                                       const Color(0xFF9F9F9F),
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                   UIUtills()
//                                                       .getProportionalWidth(
//                                                           width: 8.00),
//                                                 ),
//                                               ),
//                                               width: UIUtills()
//                                                   .getProportionalWidth(
//                                                       width: 312.00),
//                                               height: UIUtills()
//                                                   .getProportionalHeight(
//                                                       height: 66.00),
//                                               child: Center(
//                                                 child: Text(
//                                                   optionText[3],
//                                                   style: GoogleFonts.roboto(
//                                                     color:
//                                                         const Color(0xFFFFFFFF),
//                                                     fontSize: UIUtills()
//                                                         .getProportionalWidth(
//                                                             width: 20.00),
//                                                     fontWeight: FontWeight.w600,
//                                                     letterSpacing: UIUtills()
//                                                         .getProportionalWidth(
//                                                             width: -0.41),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                     ),
//                                   ],
//                                 ),
//                           SizedBox(
//                               height: UIUtills()
//                                   .getProportionalHeight(height: 37.00)),
//                         ],
//                       )),
//                 ],
//               ),
//             ),
//             SizedBox(height: UIUtills().getProportionalHeight(height: 16.00)),
//             Column(
//               children: [
//                 (displayQuestionNumber >= 5)
//                     ? SizedBox(
//                         child: GestureDetector(onTap: () async {
//                           if (QuizScreenViewModel()
//                               .getPostAnswerArray(
//                                   optionArray, optionText, optionMap)
//                               .isEmpty) {
//                             var snackBar = const SnackBar(
//                               duration: Duration(seconds: 2),
//                               content: SizedBox(
//                                   height: 25,
//                                   child:
//                                       Center(child: Text("Select an Option"))),
//                             );
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackBar);
//                           } else {
//                             try {
//                               optionIds = QuizScreenViewModel()
//                                   .getPostAnswerArray(
//                                       optionArray, optionText, optionMap);
//                               if (optionIds.isNotEmpty) {
//                                 await QuizScreenViewModel()
//                                     .postAnswers(questionNumber, optionIds);
//                                 print("post after submit");
//                                 print("********");
//                                 print("option id = $optionIds");
//                                 optionIds = [];
//                                 optionArray = [0, 0, 0, 0];
//                                 questionNumber =
//                                     await QuizScreenViewModel().getProgress();
//                                 print(
//                                     "final question before next = ${questionNumber}");
//                                 QuizScreenController.newQuestion.value++;
//                                 if (!mounted) {}
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             (const RoundScreen())));
//                               } else {
//                                 var snackBar = const SnackBar(
//                                   duration: Duration(seconds: 2),
//                                   content: SizedBox(
//                                       height: 25,
//                                       child: Center(
//                                           child: Text("Select an Option"))),
//                                 );
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(snackBar);
//                               }
//                             } catch (_) {
//                               var snackBar = const SnackBar(
//                                 duration: Duration(seconds: 2),
//                                 content: SizedBox(
//                                     height: 25,
//                                     child:
//                                         Center(child: Text("Error Occurred"))),
//                               );
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(snackBar);
//                             }
//                           }
//                           child:
//                           Container(
//                             // alignment: Alignment.bottomCenter,
//                             width: double.infinity,
//                             height:
//                                 UIUtills().getProportionalHeight(height: 72.00),
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: UIUtills()
//                                     .getProportionalWidth(width: 58.00)),
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color.fromRGBO(0, 0, 0, 1),
//                                   Color.fromRGBO(45, 45, 45, 1)
//                                 ],
//                               ),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Color.fromRGBO(0, 0, 0, 0.20),
//                                   blurRadius: 3.00,
//                                   offset: Offset(0, 2.00),
//                                 ),
//                               ],
//                               borderRadius: BorderRadius.circular(
//                                 UIUtills().getProportionalWidth(width: 15.00),
//                               ),
//                             ),
//
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Submit',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w800,
//                                     color:
//                                         const Color.fromRGBO(255, 255, 255, 1),
//                                     fontSize: UIUtills()
//                                         .getProportionalWidth(width: 20.00),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }),
//                       )
//                     : SizedBox(
//                         child: GestureDetector(onTap: () async {
//                           if (QuizScreenViewModel()
//                               .getPostAnswerArray(
//                                   optionArray, optionText, optionMap)
//                               .isEmpty) {
//                             var snackBar = const SnackBar(
//                               duration: Duration(seconds: 2),
//                               content: SizedBox(
//                                   height: 25,
//                                   child:
//                                       Center(child: Text("Select an Option"))),
//                             );
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(snackBar);
//                           } else {
//                             try {
//                               optionIds = QuizScreenViewModel()
//                                   .getPostAnswerArray(
//                                       optionArray, optionText, optionMap);
//                               print("array which will be posted = $optionIds");
//                               if (!optionIds.isEmpty) {
//                                 await QuizScreenViewModel()
//                                     .postAnswers(questionNumber, optionIds);
//                                 print("post after next");
//                                 optionIds = [];
//                                 optionArray = [0, 0, 0, 0];
//                                 questionNumber =
//                                     await QuizScreenViewModel().getProgress();
//                                 print(
//                                     "final question before next = $questionNumber");
//                                 QuizScreenController.newQuestion.value++;
//                               } else {
//                                 var snackBar = const SnackBar(
//                                   duration: Duration(seconds: 2),
//                                   content: SizedBox(
//                                       height: 25,
//                                       child: Center(
//                                           child: Text("Select an Option"))),
//                                 );
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(snackBar);
//                               }
//                             } catch (_) {
//                               var snackBar = const SnackBar(
//                                 duration: Duration(seconds: 2),
//                                 content: SizedBox(
//                                     height: 25,
//                                     child:
//                                         Center(child: Text("error occurred"))),
//                               );
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(snackBar);
//                             }
//                           }
//                           ;
//                           child:
//                           Container(
//                             // alignment: Alignment.bottomCenter,
//                             width: double.infinity,
//                             height:
//                                 UIUtills().getProportionalHeight(height: 72.00),
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: UIUtills()
//                                     .getProportionalWidth(width: 58.00)),
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color.fromRGBO(0, 0, 0, 1),
//                                   Color.fromRGBO(45, 45, 45, 1)
//                                 ],
//                               ),
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Color.fromRGBO(0, 0, 0, 0.20),
//                                   blurRadius: 3.00,
//                                   offset: Offset(0, 2.00),
//                                 ),
//                               ],
//                               borderRadius: BorderRadius.circular(
//                                 UIUtills().getProportionalWidth(width: 15.00),
//                               ),
//                             ),
//
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Next',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w800,
//                                     color:
//                                         const Color.fromRGBO(255, 255, 255, 1),
//                                     fontSize: UIUtills()
//                                         .getProportionalWidth(width: 20.00),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }),
//                       ),
//                 SizedBox(
//                   height: UIUtills().getProportionalHeight(height: 20.00),
//                 ),
//               ],
//             ),
//             SizedBox(height: UIUtills().getProportionalHeight(height: 16.00)),
//           ],
//         ));
//   }
//
//   int optionSelected(List<int> optionArray) {
//     if (optionArray == [0, 0, 0, 1]) {
//       return 3;
//     } else if (optionArray == [0, 0, 1, 0]) {
//       return 2;
//     } else if (optionArray == [0, 1, 0, 0]) {
//       return 1;
//     } else if (optionArray == [1, 0, 0, 0]) {
//       return 0;
//     } else {
//       return 0;
//     }
//   }
//
//   //TODO: DONT DELETE ELSE PRABHAS CRI
//
//   int actualquestion(String? finalQuestion) {
//     if (finalQuestion == '1') {
//       return 1;
//     } else if (finalQuestion == '2') {
//       return 2;
//     } else if (finalQuestion == '3') {
//       return 3;
//     } else if (finalQuestion == '4') {
//       return 4;
//     } else {
//       return 0;
//     }
//   }
// }
