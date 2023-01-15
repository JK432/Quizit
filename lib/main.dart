import 'package:flutter/material.dart';
import 'package:quizit/Functions/colorfunction.dart';

import 'Screens/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        unselectedWidgetColor: Palette.lightbasic,
        primarySwatch: Colors.orange,

      ),
      home: const Home(),
    );
  }
}
