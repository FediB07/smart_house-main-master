import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iotproject/screens/adminscrren.dart';
import 'package:iotproject/screens/gazscreen.dart';
import 'package:iotproject/screens/login.dart';
import 'package:iotproject/screens/tempcontroller.dart';
import 'package:iotproject/screens/userscreen.dart';
import 'package:iotproject/screens/welcomescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDTwYk0vfoiaNGDz5gdpg-XX9nlsN8q5fQ",
      appId: "1:995877004434:android:5bd772a60eb645e8a1724b",
      messagingSenderId: "995877004434",
      projectId: "smart-home-8a244",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'welcome',
      routes: {
        'welcome' : (context)=> WelcomeScreen(),
        'login' : (context)=> LoginScreen(),
        'user' :(context) => userinterfaceq(),
        'admin' : (context) => admin(),
        'gaz' : (context) => GazController(),
        'temp' :(context) => tempcontroller()
        
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true),
      home: WelcomeScreen(),
    );
  }
}



