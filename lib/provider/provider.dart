import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UtilitiesProvider extends ChangeNotifier {
  String _phoneNumber = "";

  String get phoneNumber => _phoneNumber;

  changeTorch() async {
    notifyListeners();
  }

  changeNumber(String _userInput) async {
    _phoneNumber = _userInput;

    return _phoneNumber;
    notifyListeners();
  }
}
