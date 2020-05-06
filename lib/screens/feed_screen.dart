import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/like_button.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
import 'package:FlutterGalleryApp/widgets/user_avatar.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({this.name, this.userName, this.altDescription, Key key})
      : super(key: key);

  final String name;
  final String userName;
  final String altDescription;

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text('Photo', style: TextStyle(color: AppColors.black)),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(CupertinoIcons.back, color: AppColors.grayChateau),
              onPressed: () {}),
        ),
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: <Widget>[
                _buildItem(index),
                Divider(thickness: 2.0, color: AppColors.mercury),
              ]);
            }));
  }

  Widget _buildItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Photo(photoLink: kFlutterDash),
        _photoDescription(),
        _buildPhotoMeta(),
        _userAction(),
      ],
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: <Widget>[
          UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.name == null
                  ? Text('')
                  : Text(widget.name, style: AppStyles.h1Black),
              widget.userName == null
                  ? Text('')
                  : Text(widget.userName,
                      style:
                          AppStyles.h5Black.copyWith(color: AppColors.manatee)),
            ],
          )
        ],
      ),
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
              child: LikeButton(10, true),
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
