import 'package:flutter/material.dart';
import 'package:kumari_drivers/model/PlanModal.dart';
import 'package:nb_utils/nb_utils.dart';  //https://pub.dev/packages/nb_utils
import 'package:razorpay_flutter/razorpay_flutter.dart';  //https://pub.dev/packages/razorpay_flutter

class DemoRazorPayScreen extends StatefulWidget {
   final PlanModal plan;
  const DemoRazorPayScreen({super.key,  required this.plan,  });

  @override
  DemoRazorPayScreenState createState() => DemoRazorPayScreenState();
}

class DemoRazorPayScreenState extends State<DemoRazorPayScreen> {
  late Razorpay _razorpay;
  Color appColorPrimary = Color(0xFF1157FA);

  /*fonts*/
  String fontRegular = 'Regular';
  String fontMedium = 'Medium';
  String fontSemibold = 'Semibold';
  String fontBold = 'Bold';
  /* font sizes*/
  double textSizeSmall = 12.0;
  double textSizeSMedium = 14.0;
  double textSizeMedium = 16.0;
  double textSizeLargeMedium = 18.0;
  double textSizeNormal = 20.0;
  double textSizeLarge = 24.0;
  double textSizeXLarge = 34.0;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_Fq8a7aTL51han5',
      'amount':int.parse(widget.plan.price!.replaceAll(RegExp(r'[^0-9]'), '')) * 100,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    toasty(context, "SUCCESS: " + response.paymentId.validate());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    toasty(context, "ERROR: " + response.code.toString() + " - " + response.message.validate());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    toasty(context, "EXTERNAL_WALLET: " + response.walletName.validate());
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(appColorPrimary);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 24, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16, bottom: 28),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), boxShadow: defaultBoxShadow(), color: whiteColor),
                 
                  ),
                  const SizedBox(height: 16),
               
                ],
              ),
              Divider(height: 0.5),
              Text("Name", style: TextStyle(fontSize: textSizeLargeMedium, fontFamily: fontSemibold, color: appColorPrimary) ).paddingAll(16),

              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Text("Acme Corp.", style: secondaryTextStyle()),
              ),
              Text("Email", style: TextStyle(fontSize: textSizeLargeMedium, fontFamily: fontSemibold, color: appColorPrimary) ).paddingAll(16),

              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Text("test@razorpay.com", style: secondaryTextStyle()),
              ),
              Text("Contact", style: TextStyle(fontSize: textSizeLargeMedium, fontFamily: fontSemibold, color: appColorPrimary) ).paddingAll(16),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Text("", style: secondaryTextStyle()),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 80),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                decoration: BoxDecoration(
                  color: appColorPrimary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  'Pay with RazorPay',
                  style: primaryTextStyle(color: white),
                ),
              ).onTap(
                () {
                  openCheckout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeStatusColor(Color color) async {
    setStatusBarColor(color);
  }

}