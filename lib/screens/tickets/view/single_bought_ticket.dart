import 'package:oasis_2022/utils/oasis_text_styles.dart';

import '/resources/resources.dart';

import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class SingleTicket extends StatefulWidget {
  SingleTicket({
    super.key,
    required this.unusedCount,
    required this.timeStamp,
    required this.id,
  });

  final int unusedCount;
  final String? timeStamp;
  final int id;

  @override
  State<SingleTicket> createState() => _SingleTicketState();
}

class _SingleTicketState extends State<SingleTicket> {

  String imagePath = ImageAssets.proBrosTicketImage;

  String getTimeString() {
    DateTime date = (widget.timeStamp == null
        ? DateTime.parse(
            widget.id == 1 ? '2022-10-17 19:30:00' : '2022-10-18 19:30:00')
        : DateTime.parse(widget.timeStamp!));
    int eventDuration = 90;
    DateTime date2 = date.add(Duration(minutes: eventDuration));
    String finalString =
        '${date.day} ${monthConverter(date.month)} | ${(date.hour) > 12 ? date.hour % 12 : date.hour}:${date.minute > 9 ? date.minute : '0${date.minute}'}-${(date2.hour) > 12 ? date2.hour % 12 : date2.hour}:${date2.minute > 9 ? date2.minute : '0${date2.minute}'}';
    return finalString;
  }

  @override
  void initState() {
    print(widget.timeStamp);
    imagePath = (widget.id == 1)
        ? ImageAssets.proBrosTicketImage
        : ImageAssets.N2OTicketImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.timeStamp);
    return Padding(
      padding: EdgeInsets.only(
          bottom: UIUtills().getProportionalHeight(height: 20.41)),
      child: Center(
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              width: UIUtills().getProportionalWidth(width: 388),
              height: UIUtills().getProportionalHeight(height: 138.77),
            ),
            Positioned(
                top: UIUtills()
                    .getProportionalHeight(height: widget.id == 1 ? 88 : 70),
                right: UIUtills()
                    .getProportionalWidth(width: widget.id == 1 ? 82 : 88),
                child: Stack(
                  children: [
                    Text(getTimeString(),
                        style: OasisTextStyles.poppinsRegular.copyWith(
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = widget.id == 1
                                  ? const Color(0XFFEA227A)
                                  : Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize:
                                UIUtills().getProportionalWidth(width: 12),
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            height: 1.5)),
                    Text(getTimeString(),
                        style: OasisTextStyles.poppinsRegular.copyWith(
                            color: widget.id == 1 ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize:
                                UIUtills().getProportionalWidth(width: 12),
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            height: 1.5))
                  ],
                )),
            Positioned(
                right: UIUtills()
                    .getProportionalWidth(width: widget.id == 1 ? 33 : 30),
                top: UIUtills()
                    .getProportionalHeight( height: 27),
                child: RotatedBox(
                    quarterTurns: 3,
                    child: Text('Tickets Left: ${widget.unusedCount}',
                        style: OasisTextStyles.robotoExtraBold.copyWith(
                            fontSize:
                                UIUtills().getProportionalHeight(height: 13),
                            //color: Color(0XFF3D2F86),
                            color: widget.id == 2
                                ? const Color(0XFFEDEDED)
                                : const Color(0xFF464646)))))
          ],
        ),
      ),
    );
  }

  String monthConverter(int month) {
    switch (month) {
      case 10:
        return 'October';
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'NA';
    }
  }
}
