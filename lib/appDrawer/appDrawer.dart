import '../morescreen/screens/contact_us_screen.dart';
import '../morescreen/screens/developers_screen.dart';
import '../morescreen/screens/epc_blog.dart';
import '../morescreen/screens/epc_map.dart';
import '../morescreen/screens/generalInfo.dart';
import '../morescreen/screens/hpc_blog.dart';
import '../morescreen/screens/sponsors.dart';
import '../utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class AppDrawerMenu extends StatefulWidget {
  const AppDrawerMenu({super.key});

  @override
  State<AppDrawerMenu> createState() => _AppDrawerMenuState();
}

class _AppDrawerMenuState extends State<AppDrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFFAFAFF),
      width: UIUtills().getProportionalWidth(width: 293.00),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFFAFAFF),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: UIUtills().getProportionalWidth(width: 63.39),
                  height: UIUtills().getProportionalHeight(height: 82.00),
                ),
                SizedBox(width: UIUtills().getProportionalWidth(width: 10.00)),
                SizedBox(
                  width: UIUtills().getProportionalWidth(width: 150.39),
                  height: UIUtills().getProportionalHeight(height: 76.00),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: UIUtills()
                                  .getProportionalWidth(width: 00.00)),
                          Text(
                            'BOSM',
                            style: GoogleFonts.roboto(
                              fontSize:
                                  UIUtills().getProportionalWidth(width: 35.00),
                              fontWeight: FontWeight.w700,
                              color: const Color.fromRGBO(0, 0, 0, 0.75),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: UIUtills().getProportionalHeight(height: 2.00),
                      ),
                      Text(
                        'Official BOSM app 2022',
                        style: GoogleFonts.roboto(
                          fontSize:
                              UIUtills().getProportionalWidth(width: 12.00),
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(0, 0, 0, 0.75),
                          letterSpacing:
                              UIUtills().getProportionalWidth(width: -0.41),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
                top: 3,
                bottom: 3,
                left: UIUtills().getProportionalWidth(width: 22.00)),
            horizontalTitleGap: 1.00,
            leading: SizedBox(
                // height: UIUtills().getProportionalHeight(height: 20.00),
                // width: UIUtills().getProportionalWidth(width: 20.00),
                child: SvgPicture.asset('assets/images/contactUsIcon.svg')),
            title: Text(
              'CONTACT US',
              style: GoogleFonts.poppins(
                fontSize: UIUtills().getProportionalWidth(width: 20.00),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4B4B4D),
                letterSpacing: UIUtills().getProportionalWidth(width: -0.41),
              ),
            ),
            minLeadingWidth: 30,
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const ContactScreen());
            },
          ),
          ListTile(
            horizontalTitleGap: 14.00,
            contentPadding: EdgeInsets.only(
              left: UIUtills().getProportionalWidth(width: 17.00),
              right: 0,
              top: 3,
              bottom: 3,
            ),
            leading: SvgPicture.asset('assets/images/developersIcon.svg'),
            title: Text(
              'DEVELOPERS',
              style: GoogleFonts.poppins(
                fontSize: UIUtills().getProportionalWidth(width: 20.00),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4B4B4D),
                letterSpacing: UIUtills().getProportionalWidth(width: -0.41),
              ),
            ),
            minLeadingWidth: 17,
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const DeveloperScreen());
            },
          ),
          ListTile(
            horizontalTitleGap: UIUtills().getProportionalWidth(width: 15.00),
            contentPadding: EdgeInsets.only(
              left: UIUtills().getProportionalWidth(width: 16.5),
              right: 0,
              top: 3,
              bottom: 3,
            ),
            leading: SvgPicture.asset('assets/images/blogIcon.svg'),
            title: Text(
              'HPC Blog',
              style: GoogleFonts.poppins(
                fontSize: UIUtills().getProportionalWidth(width: 20.00),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4B4B4D),
                letterSpacing: UIUtills().getProportionalWidth(width: -0.41),
              ),
            ),
            minLeadingWidth: 10,
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const HpcBlog());
            },
          ),
          ListTile(
            horizontalTitleGap: UIUtills().getProportionalWidth(width: 15.00),
            contentPadding: EdgeInsets.only(
              left: UIUtills().getProportionalWidth(width: 16.5),
              right: 0,
              top: 3,
              bottom: 3,
            ),
            leading: SvgPicture.asset('assets/images/blogIcon.svg'),
            title: Text(
              'EPC Blog',
              style: GoogleFonts.poppins(
                fontSize: UIUtills().getProportionalWidth(width: 20.00),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4B4B4D),
                letterSpacing: UIUtills().getProportionalWidth(width: -0.41),
              ),
            ),
            minLeadingWidth: 0,
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const EpcBlog());
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
              left: UIUtills().getProportionalWidth(width: 17.50),
              right: 0,
              top: 3,
              bottom: 3,
            ),
            horizontalTitleGap: UIUtills().getProportionalWidth(width: 11.00),
            leading: const Icon(Icons.location_on_outlined),
            title: Text(
              'MAP',
              style: GoogleFonts.poppins(
                fontSize: UIUtills().getProportionalWidth(width: 20.00),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4B4B4D),
                letterSpacing: UIUtills().getProportionalWidth(width: -0.41),
              ),
            ),
            minLeadingWidth: 10,
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const EpcMap());
            },
          ),
          ListTile(
            horizontalTitleGap: UIUtills().getProportionalWidth(width: 15.00),
            leading: SvgPicture.asset('assets/images/sponsorsIcon.svg'),
            title: Text(
              'Sponsors',
              style: GoogleFonts.poppins(
                fontSize: UIUtills().getProportionalWidth(width: 20.50),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4B4B4D),
                letterSpacing: UIUtills().getProportionalWidth(width: -0.41),
              ),
            ),
            minLeadingWidth: 10,
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const SponsorsScreen());
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
                right: 0,
                top: 3,
                bottom: 3,
                left: UIUtills().getProportionalWidth(width: 25.00)),
            horizontalTitleGap: UIUtills().getProportionalWidth(width: 18.00),
            leading: SvgPicture.asset('assets/images/generalInfoIcon.svg'),
            title: Text(
              'General Info',
              style: GoogleFonts.poppins(
                fontSize: UIUtills().getProportionalWidth(width: 20.00),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4B4B4D),
                letterSpacing: UIUtills().getProportionalWidth(width: -0.41),
              ),
            ),
            minLeadingWidth: 12,
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: const GeneralInformation());
            },
          ),
        ],
      ),
    );
  }
}
