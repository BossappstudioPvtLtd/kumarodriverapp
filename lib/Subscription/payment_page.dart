
import 'package:flutter/material.dart';
import 'package:kumari_drivers/components/Text_Edt.dart';
import 'package:kumari_drivers/components/image_add.dart';
import 'package:kumari_drivers/components/material_buttons.dart';
import 'package:nb_utils/nb_utils.dart';
import '../model/PlanModal.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart'; // Import Razorpay Flutter SDK

class PaymentPage extends StatefulWidget {
  final PlanModal plan;

  const PaymentPage({super.key, required this.plan});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;

  Color appColorPrimary = const Color.fromARGB(255, 250, 250, 250);

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _initiatePayment() {
    var options = {
      'key': 'rzp_test_Fq8a7aTL51han5',
      'amount':int.parse(widget.plan.price!.replaceAll(RegExp(r'[^0-9]'), '')) * 100,
      'name': 'KUMARI CABS',
      'description': 'Payment for ${widget.plan.title}',
      'prefill': {'contact': '1234567890', 'email': 'example@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    toasty(context, "SUCCESS: ${response.paymentId.validate()}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    toasty(context, "ERROR: ${response.code} - ${response.message.validate()}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    toasty(context, "EXTERNAL_WALLET: ${response.walletName.validate()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
         
          Material(
            elevation: 20,
            borderRadius: BorderRadius.circular(16),
            color: Colors.black,
            child: const Padding(
              padding: EdgeInsetsDirectional.only(start: 10, end: 10),
              child: TextEdt(
                text: 'Payment Section',
                fontSize: 32,
                color: Colors.amber,
              ),
            ),
          ),
          const ImageAdd(image: "assets/images/mobile-payment_7217472.png",height: 200,width: 400,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(32),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(32)),
                height: 300,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      50.height,
                      TextEdt(
                        text: 'Plan: ${widget.plan.title}',
                        fontSize: 26,
                        color: null,
                      ),
                      10.height,

                      TextEdt(
                        text: 'Price: ${widget.plan.price}',
                        fontSize: 18,
                        color: null,
                      ),
                      10.height,
                      TextEdt(
                        text: 'Details: ${widget.plan.subTitle}',
                        fontSize: null,
                        color: null,
                      ),
                      // Add more details as neede
                      80.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: MaterialButtons(
                          containerheight: 40,
                          borderRadius: BorderRadius.circular(12),
                          onTap:
                              _initiatePayment, // Initiate payment on button press
                          text: 'Proceed to Payment', elevationsize: 20,
                          textcolor: Colors.amber,
                          textweight: FontWeight.bold,
                          fontSize: 16,
                          meterialColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void changeStatusColor(Color color) async {
    setStatusBarColor(color);
  }
}
