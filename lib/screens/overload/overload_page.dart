
import 'package:oasis_2022/utils/oasis_text_styles.dart';

import '/utils/scroll_remover.dart';
import 'package:flutter/material.dart';
import '/../utils/ui_utils.dart';
import '../login/view/login_screen.dart';
import 'overload_one.dart';
import 'overload_three.dart';
import 'overload_two.dart';

class OverloadPage extends StatefulWidget {
  const OverloadPage({Key? key}) : super(key: key);

  @override
  State<OverloadPage> createState() => _OverloadPageState();
}

class _OverloadPageState extends State<OverloadPage> {
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  List<Widget> overloadPages = const [
    OverloadOne(),
    OverloadTwo(),
    OverloadThree(),
  ];

  double currentIndexPage = 0;
  bool onLastPage = false, hasLoader = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UIUtills().updateScreenDimesion(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: screenSize.height,
        width: screenSize.width,
        // decoration: BoxDecoration(
        //   gradient: RadialGradient(
        //     center: Alignment.topRight,
        //     radius: 1,
        //     colors: [
        //       Color(0xff1B1E35),
        //       Color(0xff1A1D3D),
        //       Color(0xff07091B),
        //       Color(0xff04050E)
        //     ],
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: UIUtills().getProportionalWidth(width: 16),
                  vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  currentIndexPage != 0
                      ? IconButton(
                          icon: Icon(Icons.arrow_back_rounded,
                              color: Color(0xFF444444),
                              size:
                                  UIUtills().getProportionalHeight(height: 39)),
                          onPressed: () {
                            _controller.previousPage(
                                curve: Curves.ease,
                                duration: Duration(milliseconds: 500));
                          },
                        )
                      : Container(),
                  TextButton(
                      onPressed: () {
                        Future.microtask(() {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const LoginScreen()),
                              (route) => false);
                        });
                      },
                      child: Text(
                        currentIndexPage == 2 ? 'Login' : 'Skip',
                        style: OasisTextStyles.robotoExtraBold.copyWith(
                            fontSize:
                                UIUtills().getProportionalWidth(width: 20)),
                      ))
                ],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: PageView.builder(
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return overloadPages[index];
                  },
                  itemCount: overloadPages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndexPage = index.toDouble();
                      if (currentIndexPage == 2) {
                        onLastPage = true;
                      } else {
                        onLastPage = false;
                      }
                    });
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (currentIndexPage == 2)
                  Future.microtask(() {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const LoginScreen()),
                        (route) => false);
                  });
                else {
                  _controller.nextPage(
                      curve: Curves.ease,
                      duration: Duration(milliseconds: 600));
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    SizedBox(
                      child: CircularProgressIndicator(
                          value: (currentIndexPage + 1) / 3,
                          strokeWidth: 2,
                          backgroundColor: Color(0xFFC0C0C0),
                          color: Color(0xFF585858)),
                      width: UIUtills().getProportionalHeight(height: 77),
                      height: UIUtills().getProportionalHeight(height: 77),
                    ),
                    // Container(
                    //   width: UIUtills().getProportionalWidth(width: 50),
                    // ),
                    // Figma Flutter Generator Ellipse296Widget - ELLIPSE
                    Container(
                        width: UIUtills().getProportionalHeight(height: 61),
                        height: UIUtills().getProportionalHeight(height: 61),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromRGBO(45, 45, 45, 1),
                                Color.fromRGBO(0, 0, 0, 1)
                              ]),
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(61, 61)),
                        )),

                    // DotsIndicator(
                    //   dotsCount: overloadPages.length,
                    //   position: currentIndexPage,
                    //   decorator: DotsDecorator(
                    //     color: Colors.white,
                    //     // Inactive color
                    //     activeColor: const Color(0xffFFFFFF),
                    //     spacing: const EdgeInsets.all(3.0),
                    //     activeSize: const Size(25.0, 8.0),
                    //     activeShape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(5.0)),
                    //   ),
                    // ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: UIUtills().getProportionalHeight(height: 19),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: UIUtills().getProportionalHeight(height: 30),
            ),
          ],
        ),
      )),
    );
  }
}
