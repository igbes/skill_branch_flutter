import 'package:FlutterGalleryApp/res/res.dart';
import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  final List<String> complaints = [
    'adult',
    'harm',
    'bully',
    'spam',
    'copyright',
    'hate',
  ];

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.more_vert, color: AppColors.grayChateau),
      onPressed: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.mercury,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    complaints.map((e) => _complaint(e, context)).toList(),
              ),
            );
          },
        );
      },
    );
  }

  Widget _complaint(String text, context) {
    return Material(
      child: InkWell(
        splashColor: Colors.blue,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          child: Text(
            text.toUpperCase(),
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
