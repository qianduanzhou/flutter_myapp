import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier{
  late String _token;
  late Map<String, dynamic> _userData;

  Map<String, dynamic> get userData => _userData;
  set userData(Map<String, dynamic> userData) {
    _userData = userData;
    notifyListeners();
  }

  String get token => _token;
  set token(String token) {
    _token = token;
    notifyListeners();
  }
}