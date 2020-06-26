import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/like_button.dart';
import 'package:FlutterGalleryApp/widgets/photo.dart';
import 'package:FlutterGalleryApp/widgets/user_avatar.dart';

class FullScreenImageArguments {
  FullScreenImageArguments({
    this.heroTag,
    this.userPhoto,
    this.photo,
    this.name,
    this.userName,
    this.altDescription,
    this.key,
    this.routeSettings,
  });

  final String heroTag;
  final String userPhoto;
  final String photo;
  final String name;
  final String userName;
  final String altDescription;
  final Key key;
  final RouteSettings routeSettings;
}

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {this.heroTag,
      this.userPhoto,
      this.photo,
      this.name,
      this.userName,
      this.altDescription,
      // this.index,
      Key key})
      : super(key: key);

  final String heroTag;
  final String userPhoto;
  final String photo;
  final String name;
  final String userName;
  final String altDescription;
  // final int index;

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
      appBar: _buildAppBar(),
      body: Column(
        children: <Widget>[
          _buildItem(),
          Divider(thickness: 2.0, color: AppColors.mercury),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    // String title = ModalRoute.of(context).settings.arguments;
    return AppBar(
      actions: <Widget>[
        ClaimBottomSheet(),
      ],
      backgroundColor: AppColors.white,
      title: Text(
        // title,
        'Photo',
        style: Theme.of(context).textTheme.headline1,
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(CupertinoIcons.back, color: AppColors.grayChateau),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Hero(tag: widget.heroTag, child: Photo(photoLink: widget.photo)),
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
              style: Theme.of(context).textTheme.headline1.copyWith(
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
          _buildButton('Save', () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Downloading photos'),
                content: Text('Are you sure you want to upload a photo?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Download',
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel',
                        style: Theme.of(context).textTheme.headline1),
                  ),
                ],
              ),
            );
          }),
          _buildButton('Visit', () async {
            OverlayState overlayState = Overlay.of(context);

            OverlayEntry overlayEntry = OverlayEntry(
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
                        child: Text('ScillBranch'),
                      ),
                    ),
                  ),
                );
              },
            );

            overlayState.insert(overlayEntry);
            await Future.delayed(Duration(seconds: 1));
            overlayEntry.remove();
          }),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
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
                          : Text(name,
                              style: Theme.of(context).textTheme.headline1),
                      userName == null
                          ? Text('')
                          : Text(name,
                              style: Theme.of(context).textTheme.headline5),
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
