import 'dart:async';

import '../utils/error_messages.dart';
import '../widgets/error_dialogue.dart';
import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool isError = false;
  late Timer timer;

  @override
  void initState() {
    timer = Timer(Duration(seconds: 20), () {
      setState(() {
        isError = true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isError
          ? Center(
              child: ErrorDialog(
                  errorMessage: ErrorMessages.timeOutError, isFatalError: true))
          : Center(
              child: SizedBox(
                height: 75,
                width: 75,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: Colors.black,
                ),
              ),
            ),
    );
  }
}
