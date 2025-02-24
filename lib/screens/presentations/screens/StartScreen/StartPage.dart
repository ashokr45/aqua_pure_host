import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../authentication/LoginPage/loginPage.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              TColors.textWhite.withOpacity(0.2),
              TColors.appBarColor.withOpacity(0.3),
              TColors.appBarColor,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: TSizes.defaultSpace * 7, right: 8.0, left: 8.0),
              child: Image(image: AssetImage('assets/Branding.png')),
            ),
            SizedBox(height: TSizes.defaultSpace * 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              SizedBox(
                height: 50,
                width: 160,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.button,
                    ),
                    onPressed: () => Get.to(() => LoginPage()),
                    child: Text(
                      "Login",
                      style: TextStyle(color: TColors.textWhite, fontSize: 20),
                    )),
              ),
              SizedBox(
                height: 50,
                width: 160,
                child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: TColors.grey,
                    ),
                    onPressed: () {},
                    child: Text(
                      "Signup",
                      style: TextStyle(color: TColors.textBlack, fontSize: 20),
                    )),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
