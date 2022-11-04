import '/resources/resources.dart';
import '/screens/matches/view/miscellaneous_screen/miscellaneous_screen.dart';
import '/utils/bosm_text_styles.dart';
import '/utils/colors.dart';
import '/utils/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MiscellaneousTab extends StatelessWidget {
  const MiscellaneousTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const MiscellaneousScreen()));
      },
      child: Container(
        width: UIUtills().getProportionalWidth(width: 390),
        height: UIUtills().getProportionalHeight(height: 80),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(UIUtills().getProportionalWidth(width: 12)),
          ),
          boxShadow: const [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05000000074505806),
                offset: Offset(0, 2.1572327613830566),
                blurRadius: 8.628931045532227)
          ],
          gradient: BosmColors.darkBlackgradient,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: UIUtills().getProportionalWidth(width: 19),
                      right: UIUtills().getProportionalWidth(width: 21)),
                  child: Image.asset(
                    ImageAssets.miscIcon,
                    height: UIUtills().getProportionalHeight(height: 40),
                    width: UIUtills().getProportionalWidth(width: 40),
                  ),
                ),
                SizedBox(
                  width: UIUtills().getProportionalWidth(width: 258),
                  child: Text(
                    'Miscellaneous',
                    overflow: TextOverflow.ellipsis,
                    style: BosmTextStyles.robotoExtraBold.copyWith(
                        fontWeight: FontWeight.w700,
                        color: BosmColors.textWhite,
                        fontSize: UIUtills().getProportionalWidth(width: 24)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: UIUtills().getProportionalWidth(width: 18.54),
                  left: UIUtills().getProportionalWidth(width: 15.84)),
              child: SvgPicture.asset(
                ImageAssets.rightIcon,
                color: BosmColors.textWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
