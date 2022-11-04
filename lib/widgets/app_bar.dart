import '../order/order_ui.dart';
import '../utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomAppBar extends StatefulWidget {
  CustomAppBar(
      {Key? key,
      required this.title,
      required this.isactionButtonRequired,
      required this.isBackButtonRequired})
      : super(key: key);
  String title;
  bool isactionButtonRequired;
  bool isBackButtonRequired;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: GoogleFonts.roboto(
            fontWeight: FontWeight.w700, fontSize: 24, color: Colors.black),
      ),
      centerTitle: true,
      shadowColor: BosmColors.shadowColorAppBar,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      iconTheme: const IconThemeData(color: Colors.black),
      leading: widget.isBackButtonRequired
          ? InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(CupertinoIcons.arrow_left),
            )
          : Container(),
      actions: widget.isactionButtonRequired
          ? [
              IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings: const RouteSettings(name: 'order'),
                    screen: OrderScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                icon: const Icon(Icons.event_note_rounded),
                color: Colors.black,
              )
            ]
          : [],
    );
  }
}
