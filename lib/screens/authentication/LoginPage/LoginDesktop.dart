import 'package:flutter/material.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:aqua_pure/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:math' as math;


import '../../presentations/screens/Dashboard/Dashboard.dart';

class LoginDesktop extends StatelessWidget {
  LoginDesktop({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = math.min(500, screenWidth * 0.5).toDouble();

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: [
                Image.asset(
                    'assets/Branding.png',
                    width: math.min(700, screenWidth), // Responsiveness for logo
                  ),
                Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: containerWidth, // Adjusts width based on screen size
                    decoration: BoxDecoration(
                      color: TColors.appBarColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Login", style: TextStyle(fontSize: TSizes.xl)),
                        Divider(
                          thickness: 2,
                          indent: 105,
                          endIndent: 105,
                          color: TColors.textBlack,
                        ),
                        const SizedBox(height: 20),
                        QTextField(
                          text: 'Email',
                          icon: Iconsax.user,
                          controller: emailController,
                          obscureText: false,
                        ),
                        const SizedBox(height: 20),
                        QTextField(
                          text: 'Password',
                          icon: Iconsax.key,
                          controller: passwordController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: TColors.appBarColor,
                            ),
                            onPressed: () {
                              Get.to(() => Dashboard());
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: TColors.textWhite, fontSize: TSizes.lg),
                            ),
                          ),
                        ),
                        const SizedBox(height: TSizes.defaultSpace)
        
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.defaultSpace*2)
              ],
            ),
          ),
      ),
    );
  }
}

class QTextField extends StatefulWidget {
  const QTextField({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
    required this.obscureText,
  });

  final String text;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;

  @override
  _QTextFieldState createState() => _QTextFieldState();
}

class _QTextFieldState extends State<QTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: TColors.textBlack,
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: TColors.textWhite,
        prefixIcon: Icon(widget.icon, color: TColors.textBlack),
        hintText: widget.text,
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: TColors.textBlack,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
    );
  }
}
