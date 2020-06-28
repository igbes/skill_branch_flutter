import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import 'app.dart';

void main() {
  // debugRepaintRainbowEnabled = true;
  runApp(MyApp());
}

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  void showOverlay(BuildContext context, Widget child) {
    // реализуйте отображение Overlay.
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: MediaQuery.of(context).viewInsets.top + 50,
          child: Material(
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                decoration: BoxDecoration(
                  color: AppColors.mercury,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('No internet connection'),
              ),
            ),
          ),
        );
      },
    );
    overlayState.insert(overlayEntry);
  }

  void removeOverlay(BuildContext context) {
    // реализуйте удаление Overlay.
    overlayEntry.remove();
  }
}
