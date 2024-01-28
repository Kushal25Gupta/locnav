import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:location/Screens/Authentication/Login_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Error during Firebase initialization: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location Explorer',
      home: LoginScreen(),
    );
  }
}
