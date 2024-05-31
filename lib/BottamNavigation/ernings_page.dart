import 'package:flutter/material.dart';
import 'package:kumari_drivers/Subscription/subscription1.dart';

class EarningsPage extends StatefulWidget {
  const EarningsPage({super.key});

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const Subscription1()));
            },
            child: const Text("Subscribtion")),
      ),
    );
  }
}
