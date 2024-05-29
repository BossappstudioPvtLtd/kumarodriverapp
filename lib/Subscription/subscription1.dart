import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../model/PlanModal.dart';
import 'payment_page.dart';

class Subscription1 extends StatefulWidget {
  const Subscription1({super.key});

  @override
  Subscription1State createState() => Subscription1State();
}

class Subscription1State extends State<Subscription1> {
  List<PlanModal> planList = [];
  PageController controller = PageController(initialPage: 0, viewportFraction: 0.85);
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
          PlanModal(title: 'Up to '),
          PlanModal(title: 'Up to 20 per month'),
          PlanModal(title: 'Single record'),
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
          PlanModal(title: ''),
          PlanModal(title: ''),
          PlanModal(title: 'Single record'),
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
          PlanModal(title: 'Up to 20 users'),
          PlanModal(title: 'Up to 200 '),
          PlanModal(title: 'Single Company record'),
        ],
        isVisible: true,
      ),
    );
    planList.add(
      PlanModal(
        image: 'assets/images/crown.png',
        title: 'Enterprise',
        subTitle: 'Solution for big organization',
        price: '299 Rs',
        planPriceSubTitle: 'per user / month',
        optionList: [
          PlanModal(title: 'Unlimited users'),
          PlanModal(title: ''),
          PlanModal(title: ''),
        ],
      ),
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                      Color.fromARGB(255, 255, 255, 255),
                      
                     /* Color.fromARGB(255, 195, 190, 190),
                      Color.fromARGB(255, 122, 120, 120),
                      Color.fromARGB(255, 206, 198, 198),
                      Color.fromARGB(255, 184, 179, 179),*/
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
                          Text(planList[index].planPriceSubTitle.validate(),
                              style: secondaryTextStyle()),
                          24.height,
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        setState(() {});
                        if (!isPageIndex) {
                          // Navigate to payment page with the selected plan
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(plan: planList[index]),
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
                            color: isPageIndex ? Colors.green : white),
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
