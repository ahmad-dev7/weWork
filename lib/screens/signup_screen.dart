import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_custom_button.dart';
import 'package:myapp/constants/k_custom_space.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/constants/k_textfield.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    onSignup() async {
      myCtrl.showLoading.value = true;
      var res = await services.signUp(
        emailController.text,
        passwordController.text,
        nameController.text,
      );
      if (res == true) {
        Get.snackbar('Success', 'Signup successfully');
        Get.offAll(()=> const HomeScreen());
      } else {
        Get.snackbar('Error', 'Signup failed');
      }

      myCtrl.showLoading.value = false;
    }

    return Scaffold(
      body: SafeArea(
        child: KHorizontalPadding(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center vertically
                children: [
                  const KVerticalSpace(),
                  const KMyText('Signup', size: 25),
                  const KVerticalSpace(),
                  KTextField(
                    controller: nameController,
                    hintText: 'Enter your name',
                    iconData: Icons.person,
                    keyboardType: TextInputType.name,
                    capitalization: TextCapitalization.words,
                  ),
                  const KVerticalSpace(),
                  KTextField(
                    controller: emailController,
                    hintText: 'Enter your email',
                    iconData: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const KVerticalSpace(),
                  KTextField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    isPasswordField: true,
                    iconData: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const KVerticalSpace(height: 50),
                  KCustomButton(
                    onTap: onSignup,
                    child: Obx(
                      () => Visibility(
                          visible: !myCtrl.showLoading.value,
                          replacement: const CircularProgressIndicator(
                              color: Colors.white),
                          child: const KMyText('Signup', color: Colors.white)),
                    ),
                  ),
                  const KVerticalSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const KMyText(
                        'Don\'t have an account?',
                        color: Colors.grey,
                      ),
                      TextButton(
                        onPressed: () => Get.to(() => const LoginScreen()),
                        child: const KMyText(
                          'Login',
                          color: accentColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
