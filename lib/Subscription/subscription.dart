import 'package:flutter/material.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  String _selectedPlan = '1month';

  void _activateSubscription(String plan) {
    // Here you would include your activation logic, possibly involving backend calls
    print('Activating $plan subscription');
    // For demonstration purposes, we're just printing to the console
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Plan'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: const Text('1 Month Subscription'),
            leading: Radio(
              value: '1month',
              groupValue: _selectedPlan,
              onChanged: (String? value) {
                setState(() {
                  _selectedPlan = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('2 Months Subscription'),
            leading: Radio(
              value: '2months',
              groupValue: _selectedPlan,
              onChanged: (String? value) {
                setState(() {
                  _selectedPlan = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('3 Months Subscription'),
            leading: Radio(
              value: '3months',
              groupValue: _selectedPlan,
              onChanged: (String? value) {
                setState(() {
                  _selectedPlan = value!;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => _activateSubscription(_selectedPlan),
            child: const Text('Activate Subscription'),
          ),
        ],
      ),
    );
  }
}
