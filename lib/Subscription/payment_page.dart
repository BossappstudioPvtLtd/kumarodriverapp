import 'package:flutter/material.dart';
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
    toasty(
        context,
        "ERROR: ${response.code} - ${response.message.validate()}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    toasty(context, "EXTERNAL_WALLET: ${response.walletName.validate()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Plan: ${widget.plan.title}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            10.height,
            Text('Price: ${widget.plan.price}',
                style: const TextStyle(fontSize: 18)),
            10.height,
            Text('Details: ${widget.plan.subTitle}',
                style: const TextStyle(fontSize: 18)),
            // Add more details as needed
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _initiatePayment, // Initiate payment on button press
              child: const Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
  
  void changeStatusColor(Color color) async {
    setStatusBarColor(color);
  }
}
