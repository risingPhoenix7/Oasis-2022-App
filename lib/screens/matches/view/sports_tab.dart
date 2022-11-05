import '/resources/resources.dart';
import '/utils/bosm_text_styles.dart';
import '/utils/colors.dart';
import '/utils/ui_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import 'scoresScreenUI/scoresScreen.dart';

class SportsTab extends StatefulWidget {
  SportsTab(
      {Key? key,
      required this.sportName,
      required this.sportId,
      required this.isFilled})
      : super(key: key);
  final String sportName;
  bool isFilled;
  final int sportId;

  @override
  State<SportsTab> createState() => _SportsTabState();
}

class _SportsTabState extends State<SportsTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ScoresScreen(
                  sportName: widget.sportName, sportId: widget.sportId)));
        },
        child: Container(
          width: UIUtills().getProportionalWidth(width: 390),
          height: UIUtills().getProportionalHeight(height: 80),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(UIUtills().getProportionalWidth(width: 12))),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05000000074505806),
                  offset: Offset(0, 2.1572327613830566),
                  blurRadius: 8.628931045532227)
            ],
            color: const Color.fromRGBO(255, 255, 255, 1),
            border: Border.all(
              color: const Color.fromRGBO(217, 217, 217, 1),
              width: 0.800000011920929,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 19.0, right: 21),
                    child: Image.asset(
                      ImageAssets.getSportIconPathFromId(widget.sportId),
                      height: UIUtills().getProportionalHeight(height: 40),
                      width: UIUtills().getProportionalWidth(width: 40),
                    ),
                  ),
                  SizedBox(
                    width: UIUtills().getProportionalWidth(width: 216),
                    child: Text(
                      widget.sportName,
                      overflow: TextOverflow.fade,
                      style: BosmTextStyles.robotoExtraBold.copyWith(
                          fontWeight: FontWeight.w700,
                          color: OasisColors.blackButtonColor,
                          fontSize: UIUtills().getProportionalWidth(width: 24)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                      onTap: () async {
                        if (widget.isFilled) {
                          widget.isFilled = false;
                          setState(() {});
                          try {
                            await FirebaseMessaging.instance
                                .unsubscribeFromTopic(
                                    widget.sportName.toLowerCase());
                            var notifBox = Hive.box("subscribeBox");
                            notifBox.put(widget.sportId, widget.isFilled);
                          } catch (e) {
                            widget.isFilled = true;
                            setState(() {});
                          }
                          print(
                              "${widget.sportName.toLowerCase()} unsubscribed");
                          if (!mounted) {}
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(milliseconds: 500),
                            content: SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text(
                                        "Unsubscribed to ${widget.sportName}"))),
                          ));
                        } else {
                          widget.isFilled = true;
                          setState(() {});
                          await FirebaseMessaging.instance
                              .subscribeToTopic(widget.sportName.toLowerCase())
                              .catchError(() {
                            print('error at notif');
                          });
                          var notifBox = Hive.box("subscribeBox");
                          notifBox.put(widget.sportId, widget.isFilled);
                          // catch(e){
                          //   print(e);
                          //   heartfilled = false;
                          //   setState(() {
                          //   });
                          // }
                          print("${widget.sportName.toLowerCase()} subscribed");
                          if (!mounted) {}
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 2),
                            content: SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text(
                                        "Subscribed to ${widget.sportName}"))),
                          ));
                        }
                      },
                      child: widget.isFilled
                          ? SvgPicture.asset('assets/images/filledHeart.svg')
                          : SvgPicture.asset(
                              ImageAssets.heartIcon,
                            )),
                  Padding(
                      padding: EdgeInsets.only(
                          right: UIUtills().getProportionalWidth(width: 18.54),
                          left: UIUtills().getProportionalWidth(width: 15.84)),
                      child: SvgPicture.asset(
                        ImageAssets.rightIcon,
                        color: const Color(0xFF181818),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
