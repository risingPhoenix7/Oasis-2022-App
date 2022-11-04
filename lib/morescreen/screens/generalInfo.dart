import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/app_bar.dart';

class GeneralInformation extends StatefulWidget {
  const GeneralInformation({Key? key}) : super(key: key);

  @override
  State<GeneralInformation> createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {
  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
            title: "General Information",
            isactionButtonRequired: false,
            isBackButtonRequired: true),
      ),
      body: const WebView(
        initialUrl:
            "https://docs.google.com/document/d/1RV4sBOxF8A6pzsrWLROONuivftLUjOYbWy5cZjJe5lo/edit?usp=sharing",
        javascriptMode: JavascriptMode.disabled,
      ),
    );
  }
}
