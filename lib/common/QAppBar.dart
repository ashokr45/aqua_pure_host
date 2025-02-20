import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';

class QAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final IconData menuIcon;
  final IconData notificationIcon;
  final IconData userIcon;
  final String title;
  final VoidCallback onPressed;
  // final PreferredSizeWidget? bottom;

  QAppBar({
    Key? key,
    this.preferredSize = const Size.fromHeight(56.0),
    required this.menuIcon,
    required this.notificationIcon,
    required this.userIcon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: TColors.appBarColor,
      title:
          Text(title, style: TextStyle(color: TColors.textWhite, fontSize: 20)),
      centerTitle: true,
      leading: IconButton(
        color: TColors.textWhite,
        onPressed: onPressed,
        icon: Icon(menuIcon),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(userIcon, color: TColors.textWhite),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(notificationIcon, color: TColors.textWhite),
        ),
      ],
    );
  }
}
