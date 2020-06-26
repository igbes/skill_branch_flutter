import 'dart:io';

import 'package:FlutterGalleryApp/res/styles.dart';
import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/fullScreenImage') {
          FullScreenImageArguments args =
              (settings.arguments as FullScreenImageArguments);
          final route = FullScreenImage(
            heroTag: args.heroTag,
            userPhoto: args.userPhoto,
            photo: args.photo,
            name: args.name,
            userName: args.userName,
            altDescription: args.altDescription,
            key: args.key,
          );

          if (Platform.isAndroid) {
            return MaterialPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          } else if (Platform.isIOS) {
            return CupertinoPageRoute(
                builder: (context) => route, settings: args.routeSettings);
          }
        }
      },
      theme: ThemeData(
        textTheme: buildAppTextTheme(),
      ),
      home: Home(),
    );
  }
}
