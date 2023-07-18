import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:riverie/features/home/screens/homeScreen.dart';
import 'package:riverie/provider/user_provider.dart';
import 'package:riverie/widgets/bottomBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/errorHandling.dart';
import '../../../constants/utils.dart';
import '../../../model/user.dart';
import 'package:http/http.dart' as http;
import '../../../constants/globalVariables.dart';

class AuthService {

  // Sign Up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async{
    try{
      User user=User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: [],
        wishlist: [],
      );

      print('Inside TRY BLOCK');

      http.Response res= await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('Post request made-sign up');

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context,
                'Account created ! Login with the same credentials!'
            );
          }
      );

    }catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  // Sign In user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,

  }) async{
    try{

      http.Response res= await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email' : email,
          'password' : password,
        }),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async{
            SharedPreferences prefs=await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context,listen: false).setUser(res.body);
            await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context,
                bottomBar.routeName,
                (route)=> false
            );
          }
      );

    }catch(e) {
      showSnackBar(context, e.toString());
    }
  }

  // Get user data (Shared Preferences)
  void getUserData({
     required BuildContext context,
  }) async{
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if(token==null){
        prefs.setString('x-auth-token', '');
      }

      var tokenRes=await http.post(
          Uri.parse('$uri/tokenIsValid'),
          headers: <String,String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token':token!
          },
      );

      var response=jsonDecode(tokenRes.body);

      if(response==true) {
        http.Response userRes=await http.get(Uri.parse('$uri/'),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token':token
        },
        );

        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.setUser(userRes.body);
      }

    }catch(e) {
      showSnackBar(context, e.toString());
      showSnackBar(context, 'TOKEN UNRECOGNISED');
    }
  }
}