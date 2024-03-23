import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_custom_button.dart';
import 'package:myapp/constants/k_custom_space.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/constants/k_textfield.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/screens/navigation_screen.dart';

class CreateTeam extends StatelessWidget {
  const CreateTeam({super.key});

  @override
  Widget build(BuildContext context) {
    var teamNameController = TextEditingController();
    var projectNameController = TextEditingController();
    var projectDescriptionController = TextEditingController();
    onCreateTeam() async {
      myCtrl.showLoading.value = true;
      var res = await services.createTeam(
        teamNameController.text,
        projectNameController.text,
        projectDescriptionController.text,
      );
      if (res == true) {
        Get.snackbar('Success', 'Team created');
        Get.offAll(
          () => const NavigationScreen(),
        );
      } else {
        Get.snackbar('Error', 'Failed to create Team');
      }
      myCtrl.showLoading.value = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const KMyText('Create Team', color: accentColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      ),
      body: KHorizontalPadding(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KTextField(
                  controller: teamNameController,
                  hintText: 'Enter Team name',
                  color: cardColor.withAlpha(255),
                  capitalization: TextCapitalization.words,
                ),
                const KVerticalSpace(),
                KTextField(
                  controller: projectNameController,
                  hintText: 'Enter Project name',
                  color: cardColor.withAlpha(255),
                  capitalization: TextCapitalization.words,
                ),
                const KVerticalSpace(),
                KTextField(
                  controller: projectDescriptionController,
                  hintText: 'Enter project  description',
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  color: cardColor.withAlpha(255),
                  capitalization: TextCapitalization.sentences,
                ),
                const KVerticalSpace(height: 40),
                KCustomButton(
                  onTap: onCreateTeam,
                  child: Obx(
                    () => Visibility(
                      visible: !myCtrl.showLoading.value,
                      replacement: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      child: const KMyText(
                        'Create Team',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
