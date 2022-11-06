import '/utils/oasis_text_styles.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';

class SingleMiscellaneousEvent extends StatelessWidget {
  SingleMiscellaneousEvent(
      {Key? key,
      required this.timeStamp,
      required this.eventName,
      required this.eventDescription,
      required this.eventConductor,
      required this.eventLocation})
      : super(key: key);

  String? timeStamp;
  String? eventName;
  String? eventDescription;
  String? eventConductor;
  String? eventLocation;
  DateTime? date;

  void timeStampConverter() {
    date = (timeStamp == null ? null : DateTime.parse(timeStamp!));
  }

  @override
  Widget build(BuildContext context) {
    timeStampConverter();
    return Padding(
      padding: EdgeInsets.only(
          left: UIUtills().getProportionalWidth(width: 20),
          right: UIUtills().getProportionalWidth(width: 20),
          bottom: UIUtills().getProportionalHeight(height: 12)),
      child: Container(
        width: UIUtills().getProportionalWidth(width: 388),
        height: UIUtills().getProportionalHeight(height: 160),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color.fromRGBO(217, 217, 217, 1),
              width: 0.8,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.8,
                  color: Color.fromRGBO(7, 95, 176, 0.15),
                  offset: Offset(0, 2),
                  blurRadius: 8)
            ]),
        child: Row(
          children: [
            Expanded(
                flex: 71,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    color: Color.fromRGBO(252, 251, 253, 1),
                    border: Border.all(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      width: 1,
                    ),
                  ),
                  child: date == null
                      ? Text(
                          'NA',
                          style: OasisTextStyles.robotoExtraBold.copyWith(
                            fontSize:
                                UIUtills().getProportionalWidth(width: 20),
                            color: Color.fromRGBO(104, 110, 131, 1),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${(date!.hour) > 12 ? date!.hour % 12 : (date!.hour > 9 ? date!.hour : '0' + date!.hour.toString())}:${(date!.minute > 9 ? date!.minute : '0' + date!.minute.toString())}',
                              style: OasisTextStyles.robotoExtraBold.copyWith(
                                fontSize:
                                    UIUtills().getProportionalWidth(width: 20),
                                color: Color.fromRGBO(104, 110, 131, 1),
                              ),
                            ),
                            SizedBox(
                              height:
                                  UIUtills().getProportionalHeight(height: 6),
                            ),
                            Text(
                              '${date!.hour >= 12 ? 'PM' : 'AM'}',
                              style: OasisTextStyles.poppinsRegular.copyWith(
                                color: Color.fromRGBO(104, 110, 131, 1),
                              ),
                            )
                          ],
                        ),
                )),
            Expanded(
              flex: 317,
              child: Padding(
                padding: EdgeInsets.only(
                    left: UIUtills().getProportionalWidth(width: 11),
                    right: UIUtills().getProportionalWidth(width: 19),
                    bottom: UIUtills().getProportionalHeight(height: 13.61),
                    top: UIUtills().getProportionalHeight(height: 18.53)),
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              eventName!,
                              style: OasisTextStyles.robotoExtraBold.copyWith(
                                  fontSize: UIUtills()
                                      .getProportionalWidth(width: 20)),
                            ),

                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 5.0, bottom: 12.13),
                          child: SizedBox(
                            width: UIUtills().getProportionalWidth(width: 280),
                            child: Text(
                              eventDescription!,
                              style: OasisTextStyles.poppinsRegular.copyWith(
                                  fontSize: UIUtills()
                                      .getProportionalWidth(width: 10),
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF6B6B6B)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eventConductor!.toUpperCase(),
                          style: OasisTextStyles.poppinsRegular.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  UIUtills().getProportionalWidth(width: 16),
                              color: Color(0xFF747EF1)),
                        ),
                        SizedBox(height: 1),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_sharp,
                              color: Color(0xFF9A9A9A),
                              size: UIUtills().getProportionalWidth(width: 11),
                            ),
                            Text(
                              eventLocation!,
                              style: OasisTextStyles.poppinsRegular.copyWith(
                                  fontSize: UIUtills()
                                      .getProportionalWidth(width: 11),
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF9A9A9A)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
