import 'package:flutter/material.dart';

class DriverAvailability with ChangeNotifier {
  bool _isDriverAvailable = false;

  bool get isDriverAvailable => _isDriverAvailable;

  void toggleAvailability() {
    _isDriverAvailable = !_isDriverAvailable;
    notifyListeners();
  }

  void setAvailability(bool value) {
    _isDriverAvailable = value;
    notifyListeners();
  }

  void setDriverAvailability(bool bool) {}
}
