import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/tickets/store_controller.dart';
import 'package:oasis_2022/screens/tickets/view/banner_details.dart';
import 'package:oasis_2022/screens/tickets/view/bottom_carousel.dart';
import 'package:oasis_2022/screens/tickets/view/merch.dart';
import 'package:oasis_2022/screens/tickets/view/prof_show.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  void initState() {
    StoreController().addListener(() {
      print('object');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        child: Stack(children: [
          const Merch(),
          Padding(
            padding: EdgeInsets.only(
              top: 600.h,
            ),
            child: BottomCarousel(),
          )
        ]),
      ),
    );
  }
}
