import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/utils/ui_utils.dart';

class quizUIScreen extends StatefulWidget {
  const quizUIScreen({Key? key}) : super(key: key);

  @override
  State<quizUIScreen> createState() => _quizUIScreenState();
}

class _quizUIScreenState extends State<quizUIScreen> {
  var optionArray = [0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
            height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 72, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text('Stand Up Soapbox',style: GoogleFonts.openSans(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w500),),
              SizedBox(height: UIUtills().getProportionalHeight(height: 53),),
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore?',style: GoogleFonts.openSans(color: Colors.white,fontSize: 20),),
              SizedBox(height: UIUtills().getProportionalHeight(height: 53),),
              Text('Select any one option',style: GoogleFonts.openSans(color: Color.fromRGBO(255, 255, 255, 0.8)
                  ,fontSize: 14,fontWeight: FontWeight.w300),),
              SizedBox(height: UIUtills().getProportionalHeight(height: 10),),
              Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        optionArray = [1, 0, 0, 0];

                        setState(() {});
                      },
                      child: optionArray[0] == 0
                          ? Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(
                              26, 28, 28, 1),
                          border: Border.all(
                            width: 1.0,


                          ),
                          borderRadius:
                          BorderRadius.circular(
                            UIUtills()
                                .getProportionalWidth(
                                width: 8.00),
                          ),
                        ),
                        width: UIUtills()
                            .getProportionalWidth(
                            width: 384.00),
                        height: UIUtills()
                            .getProportionalHeight(
                            height: 56.00),
                        child: Center(
                          child: Text(
                            'A. Lorem ipsum dolor sit amet',

                            //optionText[0],
                            textAlign: TextAlign.start,
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                                fontSize: UIUtills()
                                    .getProportionalWidth(
                                    width: 18.00),
                                fontWeight:
                                FontWeight.w600,
                                letterSpacing: UIUtills()
                                    .getProportionalWidth(
                                    width: -0.41)),
                          ),
                        ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                          boxShadow: const [],
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(209, 154, 8, 1),
                              Color.fromRGBO(254, 212, 102, 1),
                              Color.fromRGBO(227, 186, 79, 1),
                              Color.fromRGBO(209, 154, 8, 1),
                              Color.fromRGBO(209, 154, 8, 1),
                            ],
                          ),
                          border: Border.all(
                            width: 1.0,

                          ),
                          borderRadius:
                          BorderRadius.circular(
                            UIUtills()
                                .getProportionalWidth(
                                width: 8.00),
                          ),
                        ),
                        width: UIUtills()
                            .getProportionalWidth(
                            width: 384.00),
                        height: UIUtills()
                            .getProportionalHeight(
                            height: 56.00),
                        child: Center(
                          child: Text(
                            'A. Lorem ipsum dolor sit amet',
                            //optionText[0],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                                color:  Colors.black,
                                fontSize: UIUtills()
                                    .getProportionalWidth(
                                    width: 18.00),
                                fontWeight:
                                FontWeight.w600,
                                letterSpacing: UIUtills()
                                    .getProportionalWidth(
                                    width: -0.41)),
                          ),
                        ),
                      )),
                  SizedBox(
                      height: UIUtills()
                          .getProportionalHeight(
                          height: 20.00)),
                  GestureDetector(
                    onTap: () {
                      optionArray = [0, 1, 0, 0];
                      setState(() {});
                    },
                    child: optionArray[1] == 0
                        ? Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(26, 28, 28, 1),
                        border: Border.all(
                          width: 1.0,


                        ),
                        borderRadius:
                        BorderRadius.circular(
                          UIUtills()
                              .getProportionalWidth(
                              width: 8.00),
                        ),
                      ),
                      width: UIUtills()
                          .getProportionalWidth(
                          width: 384.00),
                      height: UIUtills()
                          .getProportionalHeight(
                          height: 56.00),
                      child: Center(
                        child: Text(
                          'B. Lorem ipsum dolor sit amet',
                          //   optionText[1],
                          textAlign: TextAlign.start
                          ,
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                              fontSize: UIUtills()
                                  .getProportionalWidth(
                                  width: 18.00),
                              fontWeight:
                              FontWeight.w600,
                              letterSpacing: UIUtills()
                                  .getProportionalWidth(
                                  width: -0.41)),
                        ),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        boxShadow: const [],
                        color: const Color(0xFF747EF1),
                        border: Border.all(
                          width: 1.0,

                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(209, 154, 8, 1),
                            Color.fromRGBO(254, 212, 102, 1),
                            Color.fromRGBO(227, 186, 79, 1),
                            Color.fromRGBO(209, 154, 8, 1),
                            Color.fromRGBO(209, 154, 8, 1),
                          ],
                        ),
                        borderRadius:
                        BorderRadius.circular(
                          UIUtills()
                              .getProportionalWidth(
                              width: 8.00),
                        ),
                      ),
                      width: UIUtills()
                          .getProportionalWidth(
                          width: 384.00),
                      height: UIUtills()
                          .getProportionalHeight(
                          height: 56.00),
                      child: Center(
                        child: Text(
                          'B. Lorem ipsum dolor sit amet',
                         // optionText[1],
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: UIUtills()
                                  .getProportionalWidth(
                                  width: 18.00),
                              fontWeight:
                              FontWeight.w600,
                              letterSpacing: UIUtills()
                                  .getProportionalWidth(
                                  width: -0.41)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: UIUtills()
                          .getProportionalHeight(
                          height: 20.00)),
                  GestureDetector(
                    onTap: () {
                      optionArray = [0, 0, 1, 0];

                      setState(() {});
                    },
                    child: optionArray[2] == 0
                        ? Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                            26, 28, 28, 1),
                        border: Border.all(
                          width: 1.0,

                        ),
                        borderRadius:
                        BorderRadius.circular(
                          UIUtills()
                              .getProportionalWidth(
                              width: 8.00),
                        ),
                      ),
                      width: UIUtills()
                          .getProportionalWidth(
                          width: 384.00),
                      height: UIUtills()
                          .getProportionalHeight(
                          height: 56.00),
                      child: Center(
                        child: Text(
                          'C. Lorem ipsum dolor sit amet',
                          // optionText[2],
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                              fontSize: UIUtills()
                                  .getProportionalWidth(
                                  width: 18.00),
                              fontWeight:
                              FontWeight.w600,
                              letterSpacing: UIUtills()
                                  .getProportionalWidth(
                                  width: -0.41)),
                        ),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        boxShadow: const [],
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(209, 154, 8, 1),
                            Color.fromRGBO(254, 212, 102, 1),
                            Color.fromRGBO(227, 186, 79, 1),
                            Color.fromRGBO(209, 154, 8, 1),
                            Color.fromRGBO(209, 154, 8, 1),
                          ],
                        ),
                        border: Border.all(
                          width: 1.0,

                        ),
                        borderRadius:
                        BorderRadius.circular(
                          UIUtills()
                              .getProportionalWidth(
                              width: 8.00),
                        ),
                      ),
                      width: UIUtills()
                          .getProportionalWidth(
                          width: 384.00),
                      height: UIUtills()
                          .getProportionalHeight(
                          height: 56.00),
                      child: Center(
                        child: Text(
                          'C. Lorem ipsum dolor sit amet',
                         // optionText[2],
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: UIUtills()
                                  .getProportionalWidth(
                                  width: 18.00),
                              fontWeight:
                              FontWeight.w600,
                              letterSpacing: UIUtills()
                                  .getProportionalWidth(
                                  width: -0.41)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: UIUtills()
                          .getProportionalHeight(
                          height: 20.00)),
                  GestureDetector(
                    onTap: () {
                      optionArray = [0, 0, 0, 1];

                      setState(() {});
                    },
                    child: optionArray[3] == 0
                        ? Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                            26, 28, 28, 1),
                        border: Border.all(
                          width: 1.0,

                        ),
                        borderRadius:
                        BorderRadius.circular(
                          UIUtills()
                              .getProportionalWidth(
                              width: 8.00),
                        ),
                      ),
                      width: UIUtills()
                          .getProportionalWidth(
                          width: 384.00),
                      height: UIUtills()
                          .getProportionalHeight(
                          height: 56.00),
                      child: Center(
                        child: Text(
                            'D. Lorem ipsum dolor sit amet',
                         // optionText[3],
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                              fontSize: UIUtills()
                                  .getProportionalWidth(
                                  width: 18.00),
                              fontWeight:
                              FontWeight.w600,
                              letterSpacing: UIUtills()
                                  .getProportionalWidth(
                                  width: -0.41)),
                        ),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        boxShadow: const [],
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(209, 154, 8, 1),
                            Color.fromRGBO(254, 212, 102, 1),
                            Color.fromRGBO(227, 186, 79, 1),
                            Color.fromRGBO(209, 154, 8, 1),
                            Color.fromRGBO(209, 154, 8, 1),
                          ],
                        ),
                        border: Border.all(
                          width: 1.0,

                        ),
                        borderRadius:
                        BorderRadius.circular(
                          UIUtills()
                              .getProportionalWidth(
                              width: 8.00),
                        ),
                      ),
                      width: UIUtills()
                          .getProportionalWidth(
                          width: 384.00),
                      height: UIUtills()
                          .getProportionalHeight(
                          height: 56.00),
                      child: Center(
                        child: Text(
                          'D. Lorem ipsum dolor sit amet',
                         // optionText[3],
                          style: GoogleFonts.openSans(
                            color:
                              Colors.black,
                            fontSize: UIUtills()
                                .getProportionalWidth(
                                width: 18.00),
                            fontWeight: FontWeight.w600,
                            letterSpacing: UIUtills()
                                .getProportionalWidth(
                                width: -0.41),
                          ),
                        ),

                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: UIUtills()
                      .getProportionalHeight(height: 45.00)),

              Center(
                child: InkWell(onTap: (){},
                child: Text('Submit',style: GoogleFonts.openSans(color: Color.fromRGBO(255, 255, 255, 0.8),fontSize: 20)),),
              )
            ],
          )

      ),
        ),
     );

  }
}
