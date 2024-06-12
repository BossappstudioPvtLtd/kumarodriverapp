import 'package:flutter/material.dart';

class PlanModal {
  String? title;
  String? subTitle;
  String? currency;
  String? price;
  String? period;
  bool? isAvailable;
  bool? isImportant;
  String? image;
  String? planPriceSubTitle;
  Color? containerColor;
  Color? iconColor;
  bool? isVisible;
  Color? planTitleColor;
  String? priceLinthroughTitle;
  String? color;

  List<PlanModal>? optionList;

  IconData? icon;

  PlanModal({
    this.color,
    this.title,
    this.subTitle,
    this.currency,
    this.price,
    this.period,
    this.planPriceSubTitle,
    this.isAvailable,
    this.isImportant,
    this.image,
    this.containerColor,
    this.iconColor,
    this.isVisible,
    this.planTitleColor,
    this.optionList,
    this.icon,
    this.priceLinthroughTitle,
  });
}

void main() {
  // Create a PlanModal instance
  PlanModal plan = PlanModal(
    title: "Basic Plan",
    subTitle: "Basic subscription",
    currency: "\$",
    price: "9.99",
    period: "month",
    isAvailable: true,
    isImportant: false,
    icon: Icons.ac_unit, // Set initial icon
  );

  // Change the icon
  plan.icon = Icons.star; // New icon

  // Use the PlanModal instance in your app
  runApp(MyApp(plan: plan));
}

class MyApp extends StatelessWidget {
  final PlanModal plan;

  MyApp({required this.plan});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plan Modal Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(plan.title ?? 'No Title'),
              Icon(plan.icon), // Display the icon
            ],
          ),
        ),
      ),
    );
  }
}
