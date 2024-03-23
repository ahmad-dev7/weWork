import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_custom_button.dart';
import 'package:myapp/constants/k_custom_space.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/constants/k_textfield.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/navigation_screen.dart';
import 'package:myapp/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    onLogin() async {
      myCtrl.showLoading.value = true;
      var res = await services.login(
        emailController.text,
        passwordController.text,
      );
      if (res == true) {
        Get.snackbar('Success', 'Signed-up successfully');
        if (myCtrl.userData.value.createdTeams!.isNotEmpty ||
            myCtrl.userData.value.joinedTeams!.isNotEmpty) {
          Get.offAll(() => const NavigationScreen());
        } else {
          Get.offAll(() => const HomeScreen());
        }
      } else {
        Get.snackbar('Error', 'Signup failed');
      }
      myCtrl.showLoading.value = false;
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: KHorizontalPadding(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const KVerticalSpace(),
                  const KMyText('Login', size: 25),
                  const KVerticalSpace(),
                  //* Email Textfield
                  KTextField(
                    controller: emailController,
                    hintText: 'Enter your email',
                    iconData: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const KVerticalSpace(),

                  //* Password TextField
                  KTextField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    isPasswordField: true,
                    iconData: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                  ),

                  const KVerticalSpace(height: 50),

                  //* Login button
                  KCustomButton(
                    onTap: onLogin,
                    child: Obx(
                      () => Visibility(
                        visible: !myCtrl.showLoading.value,
                        replacement: const CircularProgressIndicator(
                            color: Colors.white),
                        child: const KMyText(
                          'Login',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const KVerticalSpace(),

                  //* Signup Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const KMyText('Don\'t have an account?  ',
                          color: Colors.grey),
                      TextButton(
                        onPressed: () => Get.to(() => const SignupScreen()),
                        child: const KMyText(
                          'Signup',
                          color: accentColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
