import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../quiz/view/Quiz_ui.dart';
import 'redirect_pages/contact_us_screen.dart';
import 'redirect_pages/developer_screen.dart';
import 'redirect_pages/epc_blog.dart';
import 'redirect_pages/epc_map.dart';
import 'redirect_pages/generalInfo.dart';
import 'redirect_pages/hpc_blog.dart';
import 'redirect_pages/sponsors.dart';
import 'single_block.dart';

class MoreInfoScreen extends StatefulWidget {
  const MoreInfoScreen({Key? key}) : super(key: key);

  @override
  State<MoreInfoScreen> createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SvgPicture.asset("assets/images/events_bg.svg"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 108.h, left: 24.w),
                    child: Text(
                      "See More",
                      style: GoogleFonts.openSans(
                          fontSize: 28.sp, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 30.w, top: 108.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('assets/images/exit_button.svg',height: 32.h,width: 32.w,),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 52.h),
              SingleBlock(
                assetName: 'assets/images/more_screen_icons/standup.svg',
                name: 'Standup Soap Box',
                action: () {
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => quizUIScreen()));
                  }
                },
              ),
              SingleBlock(
                  assetName: 'assets/images/more_screen_icons/blog.svg',
                  name: 'EPC Blog',
                  action: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const EpcBlog());
                  }),
              SingleBlock(
                  assetName: 'assets/images/more_screen_icons/blog.svg',
                  name: 'HPC Blog',
                  action: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const HpcBlog());
                  }),
              SingleBlock(
                  assetName: 'assets/images/more_screen_icons/sponsors.svg',
                  name: 'Sponsors',
                  action: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const SponsorsScreen());
                  }),
              SingleBlock(
                  assetName: 'assets/images/more_screen_icons/map.svg',
                  name: 'Map',
                  action: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const EpcMap());
                  }),
              SingleBlock(
                assetName: 'assets/images/more_screen_icons/contact.svg',
                name: 'Contact us',
                action: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: const ContactScreen());
                },
              ),
              SingleBlock(
                assetName: 'assets/images/more_screen_icons/developers.svg',
                name: 'Developers',
                action: () {
                  PersistentNavBarNavigator.pushNewScreen(context,
                      screen: DevelopersScreen2());
                },
              ),
              SingleBlock(
                  assetName: 'assets/images/more_screen_icons/generalinfo.svg',
                  name: 'General Info',
                  action: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: const GeneralInformation());
                  }),
            ],
          )
        ],
      ),
    );
  }
}
