import 'package:flutter/material.dart';
import 'package:kumari_drivers/Subscription/payment_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../model/plan_modal.dart';
import 'subscription_provider.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  SubscriptionState createState() => SubscriptionState();
}

class SubscriptionState extends State<Subscription> {
  List<PlanModal> planList = [];
  PageController controller =
      PageController(initialPage: 0, viewportFraction: 0.85);
  int selectedIndex = 0;
  int pageIndex = 0;
  Color blueButtonAndTextColor = const Color(0xFF3878ec);

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    planList.add(
      PlanModal(
        image: 'assets/images/crown.png',
        title: '',
        subTitle: 'A Simplest Start to everyone',
        price: 'Free Trial',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(title: 'Available to new users only.', icon: Icons.check),
          PlanModal(title: 'Lasts for 14 days.', icon: Icons.check),
          PlanModal(
              title: 'No charges during the trial period.', icon: Icons.check),
        ],
      ),
    );
    planList.add(
      PlanModal(
        image: 'assets/images/crown.png',
        title: 'Basic',
        subTitle: 'A Simplest Start to everyone',
        price: '99 Rs',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(title: 'One plan at a time.', icon: Icons.check),
          PlanModal(title: '30 days from activation.', icon: Icons.check),
          PlanModal(title: 'No refunds for partial months.', icon: Icons.check),
        ],
      ),
    );
    planList.add(
      PlanModal(
        image: 'assets/images/crown.png',
        title: 'Standard',
        subTitle: 'For Small and medium business',
        price: '199 Rs',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(
            title: 'Up to 20 users',
            icon: Icons.check,
          ),
          PlanModal(title: '60 days from activation', icon: Icons.check),
          PlanModal(title: 'Single Company record', icon: Icons.check),
        ],
      ),
    );
    planList.add(
      PlanModal(
        image: 'assets/images/crown.png',
        title: 'Enterprise',
        subTitle: 'Solution for big organization',
        price: '299 Rs',
        planPriceSubTitle: 'per user/month',
        optionList: [
          PlanModal(title: 'Unlimited users', icon: Icons.check),
          PlanModal(title: '90 days from activation', icon: Icons.check),
          PlanModal(title: 'Subscriber-only promotions.', icon: Icons.check),
        ],
      ),
    );
  }

  String validatePlanPriceSubTitle(String? subtitle) {
    return subtitle?.isNotEmpty == true ? subtitle! : 'N/A';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = Provider.of<SubscriptionProvider>(context);

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Container(
        color: Colors.amber,
        height: context.height(),
        width: context.width(),
        child: PageView.builder(
          controller: controller,
          itemCount: planList.length,
          onPageChanged: (index) {
            pageIndex = index;
            setState(() {});
          },
          itemBuilder: (_, int index) {
            bool isPageIndex = selectedIndex == index;
            Duration duration;
            switch (index) {
              case 0:
                duration = const Duration(seconds: 30);
                break;
              case 1:
                duration = const Duration(days: 30);
                break;
              case 2:
                duration = const Duration(days: 60);
                break;
              case 3:
                duration = const Duration(days: 90);
                break;
              default:
                duration = const Duration(days: 30);
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: AnimatedContainer(
                margin: EdgeInsets.symmetric(
                    vertical: pageIndex == index ? 16 : 50, horizontal: 8),
                height: pageIndex == index ? 0.5 : 0.45,
                width: context.width(),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.1, 0.5, 0.7, 0.9],
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: defaultBoxShadow(),
                ),
                duration: 1000.milliseconds,
                curve: Curves.linearToEaseOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        planList[index].image.validate(),
                        fit: BoxFit.cover,
                        height: 190,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(planList[index].title.validate(),
                              style: boldTextStyle(size: 30)),
                          Text(planList[index].subTitle.validate(),
                              style: secondaryTextStyle()),
                          24.height,
                          Text(planList[index].price.validate(),
                              style: boldTextStyle(
                                  size: 45, color: blueButtonAndTextColor)),
                          Text(
                              validatePlanPriceSubTitle(
                                  planList[index].planPriceSubTitle),
                              style: secondaryTextStyle()),
                          24.height,
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: planList[index].optionList!.length,
                              itemBuilder: (context, i) {
                                final option = planList[index].optionList![i];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4.0), // Add vertical padding
                                  child: Row(
                                    children: [
                                      if (option.icon != null)
                                        Icon(option.icon,
                                            color: Colors.blue, size: 15.0),
                                      8.width, // Add some spacing between the icon and the text
                                      Expanded(
                                          child: Text(option.title.validate(),
                                              style:
                                                  boldTextStyle())), // Wrap the text with Expanded
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ).expand(),
                    AppButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      width: context.width() - 120,
                      onTap: () {
                        selectedIndex = index;
                        setState(() {
                          subscriptionProvider.toggleSubscription(duration);
                        });
                        if (!isPageIndex) {
                          // Navigate to payment page with the selected plan
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PaymentPage(plan: planList[index]),
                            ),
                          );
                        }
                      },
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: radius(defaultRadius)),
                      color: isPageIndex
                          ? Colors.green.shade100
                          : blueButtonAndTextColor,
                      child: TextIcon(
                        prefix: isPageIndex
                            ? Icon(Icons.check,
                                color: selectedIndex == index
                                    ? Colors.green
                                    : null,
                                size: 16)
                            : null,
                        text: isPageIndex ? ' Your current plan' : 'Upgrade',
                        textStyle: boldTextStyle(
                            size: 18,
                            color: isPageIndex ? Colors.green : Colors.white),
                      ),
                    ).paddingBottom(16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
