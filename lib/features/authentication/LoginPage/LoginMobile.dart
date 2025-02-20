import 'package:flutter/material.dart';
import 'package:aqua_pure/utils/constants/colors.dart';
import 'package:aqua_pure/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../presentations/screens/Dashboard/Dashboard.dart';

class LoginMobile extends StatelessWidget {
  LoginMobile({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: TSizes.defaultSpace * 4,
                right: 8.0,
                left: 8.0,
              ),
              child: Image.asset('assets/Branding.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 12,
                child: Wrap(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: TColors.appBarColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                          SizedBox(height: TSizes.spaceBtwInputFields * 2),
                          QTextField(
                            text: 'Email',
                            icon: Iconsax.user,
                            controller: emailController,
                            obscureText: false,
                          ),
                          SizedBox(height: TSizes.spaceBtwInputFields),
                          QTextField(
                            text: 'Password',
                            icon: Iconsax.key,
                            controller: passwordController,
                            obscureText: true,
                          ),
                          SizedBox(height: TSizes.spaceBtwInputFields),
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
                                    color: TColors.textWhite,
                                    fontSize: TSizes.lg),
                              ),

                            ),
                          ),
                          const SizedBox(height: TSizes.defaultSpace)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
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
