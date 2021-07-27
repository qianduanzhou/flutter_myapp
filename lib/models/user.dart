import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier{
  late Map<String, dynamic> _userData;

  Map<String, dynamic> get userData => _userData;
  set userData(Map<String, dynamic> userData) {
    _userData = userData;
    notifyListeners();
  }
}