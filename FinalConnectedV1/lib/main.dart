import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'home.dart';
import 'login.dart';
import 'signup.dart';
import 'emergencyCall.dart';
import 'suggestAvoid.dart';
import 'locationMap.dart';
import 'disasterNews.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LogIn(),
        '/emergencyCalldart': (context) => EmergencyCallPage(),
        '/suggestAvoid.dart': (context) =>
            SuggestAvoidPage(title: 'Suggest Avoid'),
        '/locationMap.dart': (context) => LocationMapPage(),
        '/disasterNews.dart': (context) => DisasterNewsPage(),
      },
    );
  }
}
