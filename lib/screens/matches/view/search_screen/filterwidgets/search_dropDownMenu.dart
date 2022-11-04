import '/screens/matches/view/scoresScreenUI/dropdown_controller.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDownSearchMenu extends StatefulWidget {
  const DropDownSearchMenu({super.key});

  @override
  State<DropDownSearchMenu> createState() => _DropDownSearchMenuState();
}

class _DropDownSearchMenuState extends State<DropDownSearchMenu> {
  List<String> items = ['UPCOMING', 'COMPLETED', 'SHOW ALL'];
  String? dropdownvalue;

  @override
  void initState() {
    dropdownvalue = items[FilterDropDownController.searchDropDownValue.value];
    super.initState();
  }

  void changeValue(String? val) {
    for (int i = 0; i < items.length; i++) {
      if (val == items[i]) {
        FilterDropDownController.searchDropDownValue.value = i;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(
              right: UIUtills().getProportionalWidth(width: 5.00),
              left: UIUtills().getProportionalWidth(width: 10.00)),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  offset: Offset(0, 4),
                  blurRadius: 6.00,
                ),
              ],
              borderRadius: BorderRadius.circular(
                UIUtills().getProportionalWidth(width: 14.8),
              ),
              border: Border.all(
                width: 0.8,
                color: const Color.fromRGBO(218, 218, 218, 0.5),
              ),
              color: Color.fromRGBO(255, 255, 255, 1)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: UIUtills().getProportionalWidth(width: 14.00),
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.w600,
                ),
              ),
              dropdownColor: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(
                  UIUtills().getProportionalWidth(width: 14.8)),
              elevation: 4,
              iconSize: 35,
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(
                Icons.arrow_drop_down_sharp,
                color: Colors.black,
              ),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(
                  () {
                    dropdownvalue = newValue!;
                    changeValue(dropdownvalue);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
