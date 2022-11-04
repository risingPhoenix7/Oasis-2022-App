import '/utils/ui_utils.dart';
import '/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'widgets/buyTicketsBody.dart';

class BuyTicketsScreen extends StatefulWidget {
  const BuyTicketsScreen({super.key});

  @override
  State<BuyTicketsScreen> createState() => _BuyTicketsScreenState();
}

class _BuyTicketsScreenState extends State<BuyTicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
            title: "Buy Tickets",
            isactionButtonRequired: false,
            isBackButtonRequired: true),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: UIUtills().getProportionalWidth(width: 20.00),
          ),
          child: BuyTicketsBody(),
        ),
      ),
    );
  }
}
