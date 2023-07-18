import 'package:flutter/material.dart';
import 'package:riverie/features/auth/screens/authScreen.dart';
import 'package:riverie/features/home/screens/homeScreen.dart';
import 'package:riverie/widgets/customButton.dart';
import '../../../widgets/customTextField.dart';
import '../services/auth_services.dart';

class createAccount extends StatefulWidget {
  static const String routeName='/create-account';
  const createAccount({Key? key}) : super(key: key);

  @override
  State<createAccount> createState() => _createAccountState();
}

class _createAccountState extends State<createAccount> {

  final _signUpFormKey=GlobalKey<FormState>();
  final AuthService authService=AuthService();

  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _nameController=TextEditingController();

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(context: context, email: _emailController.text, password: _passwordController.text, name: _nameController.text);
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
              height: h*0.3,
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
                key: _signUpFormKey,
                child: Column(
                  children: [
                    Container(
                      width: w,
                      margin: const EdgeInsets.only(left: 20,right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   'Welcome',
                          //   style: TextStyle(
                          //     fontSize: 50,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.blue,
                          //   ),
                          // ),
                          SizedBox(height: 50,),
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
                            child: customTextField(hintText: 'Name',obscureText: false,controller: _nameController,iconName: Icons.person),
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
                            child: customTextField(hintText: 'Email id',obscureText: false,controller: _emailController,iconName: Icons.email,),
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
                            child: customTextField(hintText: 'Password',obscureText: true,controller: _passwordController,iconName: Icons.key,),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      width: w*0.8,
                      child: customButton(
                          text: 'Sign Up',
                          onTap: () {
                            if(_signUpFormKey.currentState!.validate()){
                              signUpUser();
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
            SizedBox(height: 10,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context,AuthScreen.routeName);
                      },
                      child: Text(
                          'Log In'
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
