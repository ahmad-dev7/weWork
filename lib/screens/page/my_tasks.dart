import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_custom_space.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (myCtrl.userData.value.createdTeams != null)
                Obx(
                  () => KMyText(
                    myCtrl.userData.value.createdTeams!.last.teamName!,
                  ),
                ),
              const KVerticalSpace(),
              if (myCtrl.userData.value.joinedTeams != null)
                Obx(
                  () => KMyText(
                    myCtrl.userData.value.joinedTeams![1].teamName!,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
