import 'package:flutter/material.dart';
import 'homepage.dart';


void main() => runApp(TPOApp());

class TPOApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable debug banner
      title: 'TPO Office App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: HomePage(), // Replaces the body with the home page
    );
  }
}
