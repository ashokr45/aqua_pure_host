import 'package:flutter/material.dart';

import '../utils/constants/colors.dart';





class QContainer extends StatelessWidget {
  final String titleText;
  final String activeText;
  final String inactiveText;
  final String moreInfoText;
  final IconData titleIcon;
  final IconData moreInfoIcon;
  final Color startColor;
  final Color endColor;
  final Color dividerColor;
  final double width;
  final double height;

  const QContainer({
    super.key,
    required this.titleText,
    required this.activeText,
    required this.inactiveText,
    required this.moreInfoText,
    required this.titleIcon,
    required this.moreInfoIcon,
    required this.startColor,
    required this.endColor,
    required this.dividerColor,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: [
            startColor,
            endColor,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titleText,
                  style: TextStyle(
                    color: TColors.textWhite,
                    fontSize: width * 0.10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  titleIcon,
                  color: TColors.textWhite,
                  size: width * 0.18,
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(activeText, style: TextStyle(color: TColors.textWhite)),
                Text(inactiveText, style: TextStyle(color: TColors.textWhite)),
              ],
            ),
          ),
          Divider(color: dividerColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                moreInfoText,
                style: TextStyle(
                  color: TColors.textWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.08,
                ),
              ),
              const SizedBox(width: 3),
              Icon(
                moreInfoIcon,
                color: TColors.textWhite,
                size: width * 0.08,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
