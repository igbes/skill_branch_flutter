import 'package:FlutterGalleryApp/res/app_icons.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  LikeButton({this.likeCount, this.isliked, Key key}) : super(key: key);

  final int likeCount;
  final bool isliked;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  int likeCount;
  bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isliked;
    likeCount = widget.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(
          () {
            isLiked = !isLiked;
            if (isLiked) {
              likeCount++;
            } else {
              likeCount--;
            }
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(isLiked ? AppIcons.like_fill : AppIcons.like),
          SizedBox(width: 4.21),
          Text(likeCount.toString()),
        ],
      ),
    );
  }
}
