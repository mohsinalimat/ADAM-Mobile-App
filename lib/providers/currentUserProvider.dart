import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUserProvider extends ChangeNotifier {
  User _user;

  get getCurrentUser {
    print(_user);
    return _user;
  }

  set setCurrentUser(User user) {
    _user = user;
    notifyListeners();
  }
}
