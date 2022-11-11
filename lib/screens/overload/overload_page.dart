import 'package:flutter/material.dart';
import 'package:oasis_2022/screens/overload/overload_four.dart';
import 'package:oasis_2022/utils/oasis_text_styles.dart';
import 'package:oasis_2022/utils/scroll_remover.dart';

import '../../utils/ui_utils.dart';
import '../login/view/login_screen.dart';
import 'overload_one.dart';
import 'overload_three.dart';
import 'overload_two.dart';

class OverloadPage extends StatefulWidget {
  const OverloadPage({Key? key}) : super(key: key);

  @override
  State<OverloadPage> createState() => _OverloadPageState();
}

class _OverloadPageState extends State<OverloadPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isGoingBackWards = false;
  bool isLoader = false;
  PageController _controller = PageController(initialPage: 0, keepPage: false);
  List<Widget> overloadPages = [
    OverloadOne(),
    OverloadTwo(),
    OverloadThree(),
    OverloadFour(),
  ];

  double currentIndexPage = 0;
  bool onLastPage = false, hasLoader = false;

  @override
  void initState() {
    _animationController = AnimationController(
        value: 1.0,
        duration: const Duration(milliseconds: 180),
        reverseDuration: const Duration(milliseconds: 80),
        vsync: this);
    _animationController.addListener(() => setState(() {
          print('start');
          print(currentIndexPage);
          print(isGoingBackWards);
          print(currentIndexPage / 3 +
              (isGoingBackWards == false ? -1 : 1) *
                  (1 / 3 * _animationController.value));
        }));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeListener(() => setState(() {}));
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UIUtills().updateScreenDimesion(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
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
                    print(index);
                    print('index');
                    setState(() {
                      _animationController.value = 1;
                      _animationController.animateTo(0.0, curve: Curves.ease);

                      if (currentIndexPage < index.toDouble()) {
                        isGoingBackWards = false;
                      } else {
                        isGoingBackWards = true;
                      }
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
                if (currentIndexPage == 2) {
                  currentIndexPage = 3;
                  _animationController.value = 1;
                  _animationController.animateTo(0.0, curve: Curves.ease);
                  await Future.delayed(const Duration(milliseconds: 180));

                  setState(() {
                    isLoader = true;
                  });
                  await Future.delayed(const Duration(milliseconds: 500));

                  Future.microtask(() {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const LoginScreen()),
                        (route) => false);
                  });
                } else {
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
                      width: UIUtills().getProportionalHeight(height: 77),
                      height: UIUtills().getProportionalHeight(height: 77),
                      child: CircularProgressIndicator(
                          value: isLoader
                              ? null
                              : currentIndexPage / 3 +
                                  (isGoingBackWards == false ? -1 : 1) *
                                      (1 / 3 * _animationController.value),
                          strokeWidth: 2,
                          backgroundColor: Color(0xFFC0C0C0),
                          color: Color(0xFF585858)),
                    ),
                    Container(
                        width: UIUtills().getProportionalHeight(height: 61),
                        height: UIUtills().getProportionalHeight(height: 61),
                        decoration: const BoxDecoration(
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
