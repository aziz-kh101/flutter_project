import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/providers/cart_provider.dart';
import 'package:project/providers/food_provider.dart';
import 'package:project/providers/user_provider.dart';
import 'package:project/screens/auth/sign_in.dart';
import 'package:project/screens/auth/sign_up.dart';
import 'package:project/screens/loader.dart';
import 'package:project/screens/orders.dart';
import 'package:project/screens/tabs/custom_navigation_bar.dart';
import 'package:provider/provider.dart';

void main() async{

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => FoodProvider()),
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFEF2A39),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      ),
      routes: {
        '/': (context) => const Loader(),
        '/tabs': (context) => const CustomNavigationBar(),
        '/auth/sign-in': (context) => const SignIn(),
        '/auth/sign-up': (context) => const SignUp(),
        '/orders': (context) => const Orders(),
      },
    );
  }
}