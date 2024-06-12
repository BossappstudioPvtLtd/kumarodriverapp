import 'package:flutter/material.dart';

class SwitchState with ChangeNotifier {
  bool _switchValue = false;

  bool get switchValue => _switchValue;

  void setSwitchValue(bool value) {
    _switchValue = value;
    notifyListeners();
  }
}
