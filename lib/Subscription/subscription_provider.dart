import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionProvider with ChangeNotifier {
  bool _subscribed = false;
  Duration _trialDuration = const Duration(seconds: 30);
  int _secondsLeft = 0;
  DateTime? _endDate;
  Timer? _timer;

  bool get subscribed => _subscribed;
  Duration get trialDuration => _trialDuration;
  int get secondsLeft => _secondsLeft;
  DateTime? get endDate => _endDate;

  SubscriptionProvider() {
    _loadSubscriptionData();
  }

  void _loadSubscriptionData() async {
    final prefs = await SharedPreferences.getInstance();
    _subscribed = prefs.getBool('subscribed') ?? false;
   //_secondsLeft = prefs.getInt('secondsLeft') ?? 30;
   // print('PRINT{$_secondsLeft}');
    final endDateString = prefs.getString('endDate');
    if (endDateString != null) {
      _endDate = DateTime.parse(endDateString);
      if (_endDate!.isAfter(DateTime.now())) {
        _secondsLeft = _endDate!.difference(DateTime.now()).inSeconds;
        _startTimer();
      } else {
        _subscribed = false;
        _secondsLeft = 0;
      }
    }
    notifyListeners();
  }

  void toggleSubscription(Duration duration) async {
    _subscribed = true;
    _trialDuration = duration;
    _secondsLeft = duration.inSeconds;
    _endDate = DateTime.now().add(duration);
    _startTimer();
    _saveSubscriptionData();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft < 1) {
        timer.cancel();
        _subscribed = false;
        _saveSubscriptionData();
        notifyListeners();
      } else {
        _secondsLeft--;
        notifyListeners();
      }
    });
  }

  void _saveSubscriptionData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('subscribed', _subscribed);
    prefs.setInt('secondsLeft', _secondsLeft);
    if (_endDate != null) {
      prefs.setString('endDate', _endDate!.toIso8601String());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
