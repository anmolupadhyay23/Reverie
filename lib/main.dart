import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:riverie/features/admin/screens/adminScreen.dart';
import 'package:riverie/features/auth/screens/authScreen.dart';
import 'package:riverie/features/auth/screens/createAccount.dart';
import 'package:riverie/features/auth/services/auth_services.dart';
import 'package:riverie/features/home/screens/homeScreen.dart';
import 'package:riverie/model/user.dart';
import 'package:riverie/provider/user_provider.dart';
import 'package:riverie/router.dart';
import 'package:riverie/widgets/bottomBar.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'constants/globalVariables.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider())
      ]
      ,child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AuthService authService=AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context: context);

    FlutterNativeSplash.remove();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riverie',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black
          )
        )
      ),
      onGenerateRoute: (settings)=>generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type=='user' ? const bottomBar() : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
