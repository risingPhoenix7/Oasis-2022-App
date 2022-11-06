import 'package:oasis_2022/screens/events/view/miscellaneous_screen.dart';

import '../provider/user_details_viewmodel.dart';
import '../screens/food_stalls/view/food_stall_screen.dart';
import '../screens/quiz/view/round.dart';
import '../screens/tickets/view/tickets_screen.dart';
import '../screens/wallet_screen/view/wallet_screen.dart';
import '../utils/nav_bar_icons_icons.dart';
import '../utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  Future<void> loadUserDetails() async {
    await UserDetailsViewModel().loadDetails();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    if (UserDetailsViewModel.userDetails.JWT == null) {
      loadUserDetails();
    } else {
      setState(() {
        isLoading = false;
      });
    }
    super.initState();
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);

  List<Widget> _buildScreens() {
    return [
      const FoodStallScreen(),
      const RoundScreen(),
      const EventsScreen(),
      const TicketsScreen(),
      const WalletScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(NavBarIcons.food_stall),
        activeColorPrimary: const Color(0xFF747EF1),
        inactiveColorPrimary: const Color(0xFF696A71),
        iconSize: 25,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(NavBarIcons.quiz),
        activeColorPrimary: const Color(0xFF747EF1),
        inactiveColorPrimary: const Color(0xFF696A71),
        iconSize: 25,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(NavBarIcons.matches),
        activeColorPrimary: const Color(0xFF747EF1),
        inactiveColorPrimary: const Color(0xFF696A71),
        iconSize: 25,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('assets/images/bluetickets.svg'),
        inactiveIcon: SvgPicture.asset('assets/images/tickets.svg'),
        iconSize: 25,
      ),
      PersistentBottomNavBarItem(
        onSelectedTabPressWhenNoScreensPushed: () {},
        icon: const Icon(NavBarIcons.profile),
        activeColorPrimary: const Color(0xFF747EF1),
        inactiveColorPrimary: const Color(0xFF696A71),
        iconSize: 25,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    UIUtills().updateScreenDimesion(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    return isLoading
        ? Loader()
        : PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: const Color(0xFFFAFAFF),
            stateManagement: true,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            hideNavigationBarWhenKeyboardShows: true,
            // decoration: NavBarDecoration(
            //   borderRadius: BorderRadius.circular(10.0),
            //   colorBehindNavBar: navBarColor,
            // ),
            //popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style12,
          );
  }
}
