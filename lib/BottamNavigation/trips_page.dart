import 'package:flutter/material.dart';





class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
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
        title: Text('Choose Your Plan'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text('1 Month Subscription'),
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
            title: Text('2 Months Subscription'),
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
            title: Text('3 Months Subscription'),
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
            child: Text('Activate Subscription'),
          ),
        ],
      ),
    );
  }
}