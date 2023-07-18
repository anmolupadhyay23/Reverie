import 'package:flutter/cupertino.dart';
import 'package:riverie/model/user.dart';

class UserProvider extends ChangeNotifier{
  User _user=User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
    wishlist: [],
  );

  User get user=>_user;

  void setUser(String user) {
    _user=User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user){
    _user=user;
    notifyListeners();
  }
}