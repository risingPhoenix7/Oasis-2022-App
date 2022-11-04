import '/screens/tickets/repository/model/showsData.dart';
import '/screens/tickets/view/buyTickets/buyTicketsUI.dart';
import '/screens/tickets/view/controller/tickets_controller.dart';
import '/screens/tickets/view/single_bought_ticket.dart';
import '/screens/tickets/view_model/get_signedtickets_view_model.dart';
import '/utils/error_messages.dart';
import '/utils/scroll_remover.dart';
import '/utils/ui_utils.dart';
import '/widgets/app_bar.dart';
import '/widgets/error_dialogue.dart';
import '/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../repository/model/signedTicketsData.dart';
import '../view_model/getAllShows_view_model.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({Key? key}) : super(key: key);

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  GetSignedTicketsViewModel getSignedTicketsViewModel =
      GetSignedTicketsViewModel();
  GetShowsViewModel getShowsViewModel = GetShowsViewModel();
  bool isLoading = true;
  SignedTicketResult? signedTicketResult;

  Future<void> _populateShows() async {
    await getShowsViewModel.retrieveAllShowData();
    await getSignedTicketsViewModel.retrieveSignedShows();
    if (ShowsResult.error != null || SignedTicketResult.error != null) {
      setState(() {
        isLoading = false;
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: ErrorDialog(
                    errorMessage: ShowsResult.error ??
                        SignedTicketResult.error ??
                        ErrorMessages.unknownError),
              );
            });
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    TicketsController.refreshTicketsPageBool.addListener(() {
      print('listener called');
      _populateShows();
    });
    _populateShows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
                title: "My Tickets",
                isactionButtonRequired: false,
                isBackButtonRequired: false)),
        body: isLoading
            ? Loader()
            : RefreshIndicator(
                onRefresh: _populateShows,
                child: SizedBox(
                  height: UIUtills().getProportionalHeight(height: 926),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFAFAFF),
                    ),
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        CustomScrollView(
                          scrollBehavior: CustomScrollBehavior(),
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          slivers: <Widget>[
                            SliverPadding(
                              padding: EdgeInsets.only(
                                  top: UIUtills()
                                      .getProportionalHeight(height: 15.00)),
                              sliver:
                                  // SignedTicketResult
                                  //             .signedTickets?.shows?.length !=
                                  //         0
                                  //     ?
                                  // SliverList(
                                  //         delegate: SliverChildBuilderDelegate(
                                  //           (BuildContext context, int index) {
                                  //             print('nbumber of shows is ');
                                  //             print(index);
                                  //             return SingleTicket(
                                  //               id: SignedTicketResult.signedTickets
                                  //                       ?.shows?[index].id ??
                                  //                   1,
                                  //               timeStamp: SignedTicketResult
                                  //                   .signedTickets
                                  //                   ?.shows?[index]
                                  //                   .timeStamp,
                                  //               unusedCount: SignedTicketResult
                                  //                       .signedTickets
                                  //                       ?.shows?[index]
                                  //                       .unused_count ??
                                  //                   0,
                                  //             );
                                  //           },
                                  //           childCount: SignedTicketResult
                                  //                   .signedTickets?.shows?.length ??
                                  //               0,
                                  //         ),
                                  //       )
                                  //     :
                                  SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      int id=index+1;
                                  print(index);
                                  int findUnusedCountById() {
                                    try {
                                      for (int i = 0;
                                          i <
                                              (SignedTicketResult.signedTickets
                                                      ?.shows?.length ??
                                                  0);
                                          i++) {
                                        if (id ==
                                            SignedTicketResult
                                                .signedTickets?.shows![i].id) {
                                          return SignedTicketResult
                                                  .signedTickets!
                                                  .shows![i]
                                                  .unused_count ??
                                              0;
                                        }
                                      }
                                      return 0;
                                    } catch (e) {
                                      return 0;
                                    }
                                  }

                                  return SingleTicket(
                                      id: id,
                                      timeStamp: ShowsResult.allShowsData!
                                          .shows!.length<2?null:ShowsResult.allShowsData!
                                          .shows?[index].timestamp,
                                      unusedCount: findUnusedCountById());
                                },
                                    childCount: 2),
                              ),
                            ),
                            SliverToBoxAdapter(
                                child: SizedBox(
                                    height: UIUtills()
                                        .getProportionalHeight(height: 420)))
                            // SliverList(
                            //   delegate: SliverChildBuilderDelegate(
                            //     (BuildContext context, int index) {
                            //       print(index);
                            //       return SingleTicket(
                            //         name: SignedTicketResult.signedTickets
                            //                 ?.combos?[index].combo_name ??
                            //             'NA',
                            //         timeStamp: '',
                            //         unusedCount: SignedTicketResult
                            //             .signedTickets
                            //             ?.combos?[index]
                            //             .unused_count,
                            //         venueName: 'Not from backend',
                            //       );
                            //     },
                            //     childCount: SignedTicketResult
                            //         .signedTickets?.combos?.length??0,
                            //   ),
                            // ),
                          ],
                        ),
                        Positioned(
                          bottom: UIUtills().getProportionalHeight(height: 20),
                          left: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              PersistentNavBarNavigator
                                  .pushNewScreenWithRouteSettings(
                                context,
                                settings: const RouteSettings(name: 'order'),
                                screen: BuyTicketsScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Container(
                              // alignment: Alignment.bottomCenter,
                              width: MediaQuery.of(context).size.width,
                              height: UIUtills()
                                  .getProportionalHeight(height: 72.00),
                              margin: EdgeInsets.symmetric(
                                  horizontal: UIUtills()
                                      .getProportionalWidth(width: 20.00)),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(45, 45, 45, 1),
                                    Color.fromRGBO(0, 0, 0, 1)
                                  ],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.20),
                                    blurRadius: 3.00,
                                    offset: Offset(0, 2.00),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                  UIUtills().getProportionalWidth(width: 15.00),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Buy Tickets',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontSize: UIUtills()
                                              .getProportionalWidth(
                                                  width: 20.00),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
    // isLoading
    //   ? const Loader()
    //   : hasError
    //       ? AlertDialog(
    //           content: Text(ShowsResult.error ??
    //               SignedTicketResult?.error ??
    //               ErrorMessages.unknownError),
    //         )
    //       : Container(
    //           height: MediaQuery.of(context).size.height,
    //           child: RefreshIndicator(
    //             onRefresh: _populateShows,
    //             child: TicketScreenUI(),
    //           ),
    //         );
  }
}
