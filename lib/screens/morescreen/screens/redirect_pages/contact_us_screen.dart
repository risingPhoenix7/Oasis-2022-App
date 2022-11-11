import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/resources/resources.dart';
import 'package:oasis_2022/screens/morescreen/repo/models/contact_model.dart';
import 'package:oasis_2022/utils/colors.dart';
import 'package:oasis_2022/utils/oasis_text_styles.dart';
import 'package:oasis_2022/utils/scroll_remover.dart';
import 'package:oasis_2022/utils/ui_utils.dart';
import 'package:oasis_2022/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> contactList = [
    Contact(
      name: "Anshal Shukla",
      desc: "Publications and Correspondence",
      email: "pcr@bitsbosm.org",
      imageAsset: "vaishnavi_raghav.png",
      phoneNumber: "6395057581",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Angel Maria Baby",
      desc: "Controls",
      email: "controls@bitsbosm.org",
      imageAsset: "AbhishekMSingh.png",
      phoneNumber: "9632217970",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Ravichandra Parvatham",
      desc: "Sponsorship and Marketing",
      email: "",
      imageAsset: "RavichandranParvatham.png",
      phoneNumber: "9100955331",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Tejas Deshpande",
      desc: "Reception and Accomodation",
      email: "recnacc@bitsbosm.org",
      imageAsset: "TejasDeshpande.png",
      phoneNumber: "7350334393",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Ekansh Agarwal",
      desc: "Sports Secretary",
      email: "sportssecretary@bitsbosm.org",
      imageAsset: "EkanshAgrawal.png",
      phoneNumber: "8810211563",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Shalini Solanke",
      desc: "Joint Sports Secretary",
      email: "",
      imageAsset: "ShaliniSolanke.png",
      phoneNumber: "7058949468",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Harshvardhan Singh",
      desc: "Joint Sports Secretary",
      email: "",
      imageAsset: "HarshvardhanSingh.png",
      phoneNumber: "6350648125",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Krishay Nangia",
      desc: "Joint Sports Secretary",
      email: "",
      imageAsset: "KrishayNangia.png",
      phoneNumber: "9820075904",
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
    Contact(
      name: "Madhav Garg",
      desc: "Online Registrations",
      email: "webmaster@bitsbosm.org",
      imageAsset: "Madhav.png",
      phoneNumber: '9911448690',
      githubUsername: "",
      linkedinUsername: "",
      twitterUsername: "",
      behanceUsername: "",
      dribbleUsername: "",
      instagramUsername: "",
      emailExists: false,
      phoneNumberExists: false,
      descExists: false,
      imageAssetExists: false,
      githubExists: false,
      linkedinExists: false,
      twitterExists: false,
      behanceExists: false,
      dribbleExists: false,
      instagramExists: false,
    ),
  ];

  Future<void> _launchMail(String email) async {
    final Uri _mailurl = Uri.parse('mailto:$email');
    await launchUrl(_mailurl);
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri _callurl = Uri.parse('tel:$phoneNumber');
    await launchUrl(_callurl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
              title: "Contact Us",
              isactionButtonRequired: false,
              isBackButtonRequired: true)),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: UIUtills().getProportionalHeight(height: 20),
          top: UIUtills().getProportionalHeight(height: 20),
          left: UIUtills().getProportionalWidth(width: 36),
          right: UIUtills().getProportionalWidth(width: 36),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing:
                        24.w,
                    mainAxisSpacing:
                        20.h,
                    crossAxisCount: 2,
                    childAspectRatio: 0.66),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF17181C),
                        borderRadius: BorderRadius.circular(10.r)),
                    width: UIUtills().getProportionalWidth(width: 182),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical:
                              UIUtills().getProportionalHeight(height: 16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Container(
                              height: 113.h,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Color.fromRGBO(209, 154, 8, 1),
                                Color.fromRGBO(254, 212, 102, 1),
                                Color.fromRGBO(227, 186, 79, 1),
                                Color.fromRGBO(209, 154, 8, 1),
                                Color.fromRGBO(209, 154, 8, 1),
                              ])),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.w, vertical: 1.h),
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/images/${contactList[index].imageAsset}",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 12.h),
                            child: Center(
                              child: Text(
                                contactList[index].name,
                                textAlign: TextAlign.center,
                                style: OasisTextStyles.openSansSubHeading
                                    .copyWith(
                                        color: Colors.white, fontSize: 16.sp),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top:
                                    16.08.h,
                                bottom: 20.35.h),
                            child: Center(
                              child: Text(
                                contactList[index].desc,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: OasisTextStyles
                                        .openSansSubHeading
                                        .copyWith(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: OasisColors.primaryYellow,
                                )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width:
                                UIUtills().getProportionalWidth(width: 65.57),
                            height:
                                UIUtills().getProportionalHeight(height: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () async {
                                      await _launchPhone(
                                          contactList[index].phoneNumber);
                                      await Clipboard.setData(ClipboardData(
                                          text:
                                              contactList[index].phoneNumber));
                                    },
                                    child: Icon(
                                      Icons.phone,
                                      size: UIUtills()
                                          .getProportionalWidth(width: 20),
                                      color: Colors.grey,
                                    )),
                                InkWell(
                                    onTap: () async {
                                      await _launchMail(
                                          contactList[index].email);
                                      await Clipboard.setData(ClipboardData(
                                          text: contactList[index].email));
                                    },
                                    child: Icon(
                                      size: UIUtills()
                                          .getProportionalWidth(width: 20),
                                      Icons.email,
                                      color: Colors.grey,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: contactList.length),
          ),
        ),
      ),
    );
  }
}
