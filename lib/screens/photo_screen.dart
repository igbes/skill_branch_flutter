import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/like_button.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
import 'package:FlutterGalleryApp/widgets/user_avatar.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {this.userPhoto,
      this.photo,
      this.name,
      this.userName,
      this.altDescription,
      this.index,
      Key key})
      : super(key: key);

  final String userPhoto;
  final String photo;
  final String name;
  final String userName;
  final String altDescription;
  final int index;

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _playAnimation();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward();
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Photo', style: TextStyle(color: AppColors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back, color: AppColors.grayChateau),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          _buildItem(),
          Divider(thickness: 2.0, color: AppColors.mercury),
        ],
      ),
    );
  }

  Widget _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(
            tag: 'flutterLogo-${widget.index}',
            child: Photo(photoLink: widget.photo)),
        _photoDescription(),
        _BuildPhotoMeta(
          controller: _controller,
          name: widget.name,
          userName: widget.userName,
          userPhoto: widget.userPhoto,
        ),
        _userAction(),
      ],
    );
  }

  Widget _photoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: widget.altDescription == null
          ? Text('')
          : Text(widget.altDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(
                color: Colors.black,
              )),
    );
  }

  Widget _userAction() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 40,
            width: 120,
            child: Center(
              child: LikeButton(likeCount: 10, isliked: true),
            ),
          ),
          _button('Save'),
          _button('Visit'),
        ],
      ),
    );
  }

  Widget _button(text) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.all(Radius.circular(8))),
        height: 40,
        width: 120,
        child: Center(
            child: Text(text,
                style: AppStyles.h1Black.copyWith(color: Colors.white))),
      ),
    );
  }
}

class _BuildPhotoMeta extends StatelessWidget {
  _BuildPhotoMeta(
      {Key key, this.controller, this.name, this.userName, this.userPhoto})
      : userAvaterOpacity = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              curve: Curves.ease,
            ),
          ),
        ),
        textOpacity = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1.0,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final String userPhoto;
  final String name;
  final String userName;

  final Animation<double> controller;
  final Animation<double> userAvaterOpacity;
  final Animation<double> textOpacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: AnimatedBuilder(
          builder: (_, __) {
            return Row(
              children: <Widget>[
                Opacity(
                  opacity: userAvaterOpacity.value,
                  child: UserAvatar(userPhoto),
                ),
                SizedBox(width: 10),
                Opacity(
                  opacity: textOpacity.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      name == null
                          ? Text('')
                          : Text(name, style: AppStyles.h1Black),
                      userName == null
                          ? Text('')
                          : Text(
                              '@$userName',
                              style: AppStyles.h5Black
                                  .copyWith(color: AppColors.manatee),
                            ),
                    ],
                  ),
                )
              ],
            );
          },
          animation: controller,
        ),
      ),
    );
  }
}
