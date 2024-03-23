import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/user_data.dart';
import 'package:myapp/screens/login_screen.dart';

class MyProgress extends StatelessWidget {
  const MyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () {
            myCtrl.userData.value = UserData();
            Get.offAll(() => const LoginScreen());
            myCtrl.dispose();
          },
          icon: const Icon(Icons.logout, color: Colors.red),
        ),
      ),
    );
  }
}
