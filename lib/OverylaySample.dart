import 'package:flutter/material.dart';

import 'generated/assets.dart';

class OverlaySample extends StatefulWidget {
  const OverlaySample({super.key});

  @override
  State<OverlaySample> createState() => _OverlaySampleState();
}

class _OverlaySampleState extends State<OverlaySample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Wrap with Stack
        children: [
          Positioned(
            top: 40,
            left: 10,
            width: 100,
            height: 50,
            child: Image.asset(Assets.overlayAsset1),
          ),
        ],
      ),
    );
  }
}
