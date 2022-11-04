import '/screens/quiz/view/quiz_screen_controller.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CountdownTimer extends StatefulWidget {
  CountdownTimer({super.key, required this.timestamp});

  int? timestamp;

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _CountdownTimerState extends State<CountdownTimer>
    with TickerProviderStateMixin {
  late AnimationController controller;

  rebuildAnimationController() {
    setState(() {
      print(controller.value);
      controller = AnimationController(
          vsync: this, duration: Duration(seconds: widget.timestamp!.toInt()));
      controller.repeat();
      controller.forward();
    });
  }

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.timestamp!.toInt()))
      ..addListener(() {
        // if(controller.isCompleted){
        //   controller.reset();
        //   QuizScreenController.newQuestion.value++;
        // }
        setState(() {});
      });
    controller.repeat();
    controller.forward();
    QuizScreenController.newQuestion.addListener(() {
      rebuildAnimationController();
      // if(controller.isCompleted){
      //   controller.reset();
      //   QuizScreenController.newQuestion.value++;
      // }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 28,
            width: double.infinity,
            child: RotatedBox(
              quarterTurns: 2,
              child: LinearProgressIndicator(
                valueColor: const AlwaysStoppedAnimation(Colors.white),
                backgroundColor: Colors.black,
                value: controller.value,
                semanticsLabel: 'Linear progress indicator',
              ),
            ),
          ),
        ),
        ((widget.timestamp!.toInt() -
                        (controller.value * widget.timestamp!.toInt()))
                    .toInt() >
                (widget.timestamp!.toInt() / 2) - 1)
            ? Text(
                (widget.timestamp!.toInt() -
                        (controller.value * widget.timestamp!.toInt()))
                    .toInt()
                    .toString(),
                style: const TextStyle(color: Colors.white),
              )
            : Text(
                (widget.timestamp!.toInt() -
                        (controller.value * widget.timestamp!.toInt()))
                    .toInt()
                    .toString(),
                style: const TextStyle(color: Colors.black),
              ),
        Container(
          padding: EdgeInsets.only(
              left: UIUtills().getProportionalWidth(width: 285.00),
              right: UIUtills().getProportionalWidth(width: 0.00)),
          child: SvgPicture.asset(
            'assets/images/quizClock.svg',
            width: UIUtills().getProportionalWidth(width: 13),
            height: UIUtills().getProportionalHeight(height: 15.17),
          ),
        ),
      ],
    );
  }
}
