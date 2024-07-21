import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kumari_drivers/Subscription/payment_page.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../model/plan_modal.dart';
import '../Subscription/subscription_provider.dart';

class SubscriptionButton extends StatefulWidget {
  const SubscriptionButton({super.key});

  @override
  SubscriptionButtonState createState() => SubscriptionButtonState();
}

class SubscriptionButtonState extends State<SubscriptionButton> {
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
        title: '',
        subTitle: 'A Simplest Start to everyone'.tr(),
        price: 'Free Trial',
        planPriceSubTitle: 'per user/month'.tr(),
        optionList: [
          PlanModal(
            title: 'Up to 1 user'.tr(),
          ),
          PlanModal(
            title: 'Up to 20 records per month'.tr(),
          ),
          PlanModal(
            title: 'Single record'.tr(),
          ),
        ],
      ),
    );
    planList.add(
      PlanModal(
        title: 'Basic'.tr(),
        subTitle: 'A Simplest Start to everyone'.tr(),
        price: '99 Rs',
        planPriceSubTitle: 'per user/month'.tr(),
        optionList: [
          PlanModal(
            title: 'Up to 10 users'.tr(),
          ),
          PlanModal(
            title: 'Up to 100 records per month'.tr(),
          ),
          PlanModal(
            title: 'Single record'.tr(),
          ),
        ],
      ),
    );
    planList.add(
      PlanModal(
        title: 'Standard'.tr(),
        subTitle: 'For Small and medium business'.tr(),
        price: '199 Rs',
        planPriceSubTitle: 'per user/month'.tr(),
        optionList: [
          PlanModal(
            title: 'Up to 20 users'.tr(),
          ),
          PlanModal(
            title: 'Up to 200 records per month'.tr(),
          ),
          PlanModal(
            title: 'Single Company record'.tr(),
          ),
        ],
      ),
    );
    planList.add(
      PlanModal(
        title: 'Enterprise'.tr(),
        subTitle: 'Solution for big organization'.tr(),
        price: '299 Rs',
        planPriceSubTitle: 'per user/month'.tr(),
        optionList: [
          PlanModal(
            title: 'Unlimited users'.tr(),
          ),
          PlanModal(
            title: 'Unlimited records'.tr(),
          ),
          PlanModal(
            title: 'Multiple Company records'.tr(),
          ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [Image.asset("assets/images/sub.png",),
            
            Container(
              height: context.height(),
              width: context.width(),
              
            
              child: Padding(
                  padding: const EdgeInsets.only(top: 230),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1, ),
                      child: Container(
                        color: Colors.white,
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
                              padding: const EdgeInsets.symmetric(vertical:70,horizontal: 12),
                              child: Material(
                                color:Colors.amber,
                                elevation: 20,
                                borderRadius: BorderRadius.circular(12),
                                child: AnimatedContainer(
                                  margin: EdgeInsets.symmetric(
                                      vertical: pageIndex == index ? 16 : 15,
                                      horizontal: 8),
                                  height: pageIndex == index ? 0.5 : 0.10,
                                  width: 40,
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
                                                    size: 45,
                                                    color: blueButtonAndTextColor)),
                                            Text(
                                                validatePlanPriceSubTitle(
                                                    planList[index].planPriceSubTitle),
                                                style: secondaryTextStyle()),
                                            24.height,
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16),
                                              child: UL(
                                                symbolType: SymbolType.Bullet,
                                                symbolColor: Colors.blue,
                                                spacing: 24,
                                                children: List.generate(
                                                  planList[index].optionList!.length,
                                                  (i) => Text(
                                                      planList[index]
                                                          .optionList![i]
                                                          .title
                                                          .validate(),
                                                      style: boldTextStyle()),
                                                ),
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
                                            subscriptionProvider
                                                .toggleSubscription(duration);
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
                                          text: isPageIndex
                                              ? ' Your current plan'.tr()
                                              : 'Upgrade'.tr(),
                                          textStyle: boldTextStyle(
                                              size: 18,
                                              color: isPageIndex
                                                  ? Colors.green
                                                  : Colors.white),
                                        ),
                                      ).paddingBottom(16),
                                      /* MaterialButton(
                                    onPressed: () {
                                      subscriptionProvider.toggleSubscription(duration);
                                      setState(() {});
                                    },
                                    color: subscriptionProvider.trialDuration == duration ? Colors.green : Colors.blue,
                                    textColor: Colors.white,
                                    child: Text(
                                      subscriptionProvider.trialDuration == duration ? 'Subscribed' : 'Subscribe',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),*/
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )),
            ),
            ]),
          ],
        ),
      ),
    );
  }
}
