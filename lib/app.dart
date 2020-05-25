import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: FullScreenImage(
      //     name: 'Vasya',
      //     userName: 'Vasya',
      //     altDescription: 'This is Flutter dash. I like it :)'),
      home:Home(),
    );
  }
}
