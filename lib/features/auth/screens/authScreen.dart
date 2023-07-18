import 'package:flutter/material.dart';
import 'package:riverie/features/auth/screens/createAccount.dart';
import 'package:riverie/widgets/customButton.dart';

import '../../../widgets/customTextField.dart';
import '../services/auth_services.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName= '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final _signInFormKey=GlobalKey<FormState>();
  final AuthService authService=AuthService();

  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController=TextEditingController();

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() {
    authService.signInUser(context: context, email: _emailController.text, password: _passwordController.text);
    print('CLICKED');
  }

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Reverie'),backgroundColor: Colors.white,centerTitle: true,foregroundColor: Colors.black,),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: w,
              height: h*0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/newLogin.png"
                  ),
                  fit: BoxFit.cover
                )
              ),
            ),
            // This is a form
            Container(
              child: Form(
                key: _signInFormKey,
                child: Column(
                  children: [
                    Container(
                      width: w,
                      margin: const EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   'Hello',
                          //   style: TextStyle(
                          //     fontSize: 70,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.blue,
                          //   ),
                          // ),
                          // Text(
                          //   'Ola Amigos',
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //     color: Colors.blueAccent,
                          //   ),
                          // ),
                          SizedBox(height: 20,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 7,
                                  offset: Offset(1,1),
                                  color: Colors.grey.withOpacity(0.2)
                                )
                              ]
                            ),
                            child: customTextField(controller: _emailController,hintText: 'Email id',obscureText: false,iconName: Icons.email,),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 7,
                                      offset: Offset(1,1),
                                      color: Colors.grey.withOpacity(0.2)
                                  )
                                ]
                            ),
                            child: customTextField(controller: _passwordController,hintText: 'Password',obscureText: true,iconName: Icons.key,),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      width: w*0.8,
                      child: customButton(
                          text: 'Sign In',
                          onTap: () {
                            if(_signInFormKey.currentState!.validate()){
                              signInUser();
                            }
                          },
                          fgColor: Colors.white,
                          bgColor: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Up till here
            SizedBox(height: 30,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context,createAccount.routeName);
                      },
                      child: Text(
                          'Create Acoount'
                      )
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
