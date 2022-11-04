import '/utils/scroll_remover.dart';
import '/utils/ui_utils.dart';
import '/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperScreen extends StatefulWidget {
  const DeveloperScreen({Key? key}) : super(key: key);

  @override
  State<DeveloperScreen> createState() => _DeveloperScreenState();
}

class _DeveloperScreenState extends State<DeveloperScreen> {
  Future<void> _launchGithub(String gituser) async {
    final Uri _profileUrl = Uri.parse('https://github.com/$gituser');
    await launchUrl(_profileUrl);
  }

  Future<void> _launchLinkedin(String linkedinUser) async {
    final Uri _profileUrl =
        Uri.parse('https://www.linkedin.com/in/$linkedinUser');
    await launchUrl(_profileUrl);
  }

  Future<void> _launchTwitter(String twitterUser) async {
    final Uri _profileUrl = Uri.parse('https://twitter.com/$twitterUser');
    await launchUrl(_profileUrl);
  }

  Future<void> _launchBehance(String behanceUser) async {
    final Uri _profileUrl = Uri.parse('https://www.behance.net/$behanceUser');
    await launchUrl(_profileUrl);
  }

  Future<void> _launchDribble(String dribbleUser) async {
    final Uri _profileUrl =
        Uri.parse('https://www.linkedin.com/in/$dribbleUser');
    await launchUrl(_profileUrl);
  }

  Future<void> _launchInstagram(String instagramUser) async {
    final Uri _profileUrl =
        Uri.parse('https://www.instagram.com/$instagramUser');
    await launchUrl(_profileUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
              title: "Developers",
              isactionButtonRequired: false,
              isBackButtonRequired: true)),
      body: Padding(
        padding: EdgeInsets.only(
            bottom: UIUtills().getProportionalHeight(height: 20),
            top: UIUtills().getProportionalHeight(height: 20),
            left: UIUtills().getProportionalWidth(width: 36),
            right: UIUtills().getProportionalWidth(width: 36)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 2,
                  childAspectRatio: 0.57),
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/ShashvatSingh.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Shashvat Singh',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'App Developer',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchGithub('shashvat1965');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/githubIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin('shashvatsingh');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchTwitter('Xcarnage__');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/twitterIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/AchinthyaHebbar.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Achinthya Hebbar',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                              height:
                                  UIUtills().getProportionalHeight(height: 34),
                              width:
                                  UIUtills().getProportionalWidth(width: 142),
                              child: Center(
                                child: Text(
                                  'App Developer',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: UIUtills()
                                              .getProportionalWidth(width: 11),
                                          fontWeight: FontWeight.w500)),
                                ),
                              )),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchGithub('risingPhoenix7');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/githubIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 24.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin('achinthya-hebbar');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/LovenyaJain.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Lovenya Jain',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'App Developer',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchGithub('lovenya');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/githubIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin(
                                      'lovenya-jain-44848818a/');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchTwitter('lovenyajain');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/twitterIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/PrabhasKumarAlamuri.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'A. Prabhas Kumar',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'App Developer',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchGithub('APRABHASKUMAR');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/githubIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 24.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin(
                                      'prabhas-kumar-alamuri/');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/SejalAgarwal.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Sejal Agarwal',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'UI/UX Design',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchBehance('sejalagarwal12');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/behanceIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin(
                                      'sejal-agarwal-618176228');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchTwitter('sejalag44718131');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/twitterIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/ShivangRai.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Shivang\nRai',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'UI/UX Design',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchBehance('shivangrai2');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/behanceIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin(
                                      'shivang-rai-36a0481bb');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchInstagram('shivang0305');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/instagramIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/AdityaPatil.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Aditya\nPatil',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'UI/UX Design',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchBehance('AnAvUser');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/behanceIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin(
                                      'aditya-patil-aa2431230');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchTwitter(
                                      'AnAvUser?t=3zMTVg6rAofnDcwFSdsATQ&s=09');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/twitterIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/SwahaPati.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Swaha\nPati',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'UI/UX Design',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchBehance('patiswaha');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/behanceIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin('swahapati');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchTwitter('swahapati');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/twitterIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/SatwikRath.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Satwik\nRath',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'UI/UX Design',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchBehance('satwikrath');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/behanceIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin(
                                      'satwik-rath-70034421b');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchInstagram('_satw_k');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/instagramIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/HarshSingh.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Harsh\nSingh',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'Backend Dev',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchGithub('DankMemes4President');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/githubIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin(
                                      'harsh-singh-049838227');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchTwitter(
                                      'harsh_singh58?t=NDO5fvFMXJfGMIo5-cOSQw&s=09');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/twitterIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/PrakharGurunani.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Prakhar Gurunani',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'Backend Dev',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchGithub('FirePing32');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/githubIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin('prakhargurunani');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 19.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchTwitter('FirePing32');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/twitterIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/MaanasSingh.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Maanas Singh',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'Backend Dev',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchGithub('Maanas-23');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/githubIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 24.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin('maanas23');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/HarshithVasireddy.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Harshith Vasireddy',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'Backend Dev',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchGithub('ode');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/githubIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 24.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchTwitter('endofunct');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/twitterIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(116, 126, 241, 0.15),
                            blurRadius: 8,
                            offset: Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  width: UIUtills().getProportionalWidth(width: 170),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: UIUtills().getProportionalHeight(height: 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/UtkarshSharma.png",
                          height: UIUtills().getProportionalHeight(height: 132),
                          width: UIUtills().getProportionalWidth(width: 138),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 50),
                            width: UIUtills().getProportionalWidth(width: 104),
                            child: Center(
                              child: Text(
                                'Utkarsh Sharma',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: UIUtills()
                                        .getProportionalWidth(width: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: UIUtills().getProportionalHeight(height: 4),
                              bottom:
                                  UIUtills().getProportionalHeight(height: 8)),
                          child: SizedBox(
                            height:
                                UIUtills().getProportionalHeight(height: 34),
                            width: UIUtills().getProportionalWidth(width: 142),
                            child: Center(
                              child: Text(
                                'Backend Dev',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: UIUtills()
                                            .getProportionalWidth(width: 11),
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: UIUtills().getProportionalWidth(width: 170),
                          height: UIUtills().getProportionalHeight(height: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await _launchGithub('utkarsh314');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/githubIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: UIUtills()
                                    .getProportionalWidth(width: 24.00),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await _launchLinkedin('utkarsh314');
                                },
                                child: SvgPicture.asset(
                                  'assets/images/linkedinIcon.svg',
                                  width: UIUtills()
                                      .getProportionalWidth(width: 20.00),
                                  height: UIUtills()
                                      .getProportionalHeight(height: 20.00),
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
