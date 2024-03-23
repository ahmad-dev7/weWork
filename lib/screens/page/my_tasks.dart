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
              const KMyText('Created Teams', weight: FontWeight.bold),
              const KVerticalSpace(height: 10),
              if (myCtrl.userData.value.createdTeams != null)
                for (var i = 0;
                    i < myCtrl.userData.value.createdTeams!.length;
                    i++)
                  Obx(
                    () => KMyText(
                        myCtrl.userData.value.createdTeams![i].teamName!),
                  ),
              const KVerticalSpace(),
              const KMyText('Joined Teams', weight: FontWeight.bold),
              const KVerticalSpace(height: 10),
              if (myCtrl.userData.value.joinedTeams != null)
                for (var i = 0;
                    i < myCtrl.userData.value.joinedTeams!.length;
                    i++)
                  Obx(
                    () => KMyText(
                      myCtrl.userData.value.joinedTeams![i].teamName!,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
