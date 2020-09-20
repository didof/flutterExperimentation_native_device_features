import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<CustomAppBarAction> actions;
  CustomAppBar({
    Key key,
    @required this.title,
    this.actions,
  })  : assert(title != null),
        super(key: key);

  final _appBar = AppBar();

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appBar.preferredSize.height);
}

class CustomAppBarAction extends StatelessWidget {
  final IconData iconData;
  final Function onPressed;
  const CustomAppBarAction({Key key, this.iconData, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(iconData),
      onPressed: onPressed,
    );
  }
}
