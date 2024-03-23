import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_custom_button.dart';
import 'package:myapp/constants/k_custom_space.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/constants/k_textfield.dart';
import 'package:myapp/constants/k_values.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/screens/create_team_screen.dart';
import 'package:myapp/screens/navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var teamCodeController = TextEditingController();
    onJoinTeam() async {
      var res = await services.joinTeam(teamCodeController.text);
      if (res[0] == true) {
        Get.snackbar('Success', res[1]);
        Get.off(const NavigationScreen());
      } else {
        Get.snackbar('Error', res[1]);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: accentColor),
      ),
      body: KHorizontalPadding(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KCustomButton(
              onTap: () => Get.to(() => const CreateTeam()),
              color: accentColor,
              child: const KMyText('Create Team', color: Colors.white),
            ),
            const KVerticalSpace(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: accentColor.withOpacity(0.3),
                  border: Border.all(color: Colors.white)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: KTextField(
                    controller: teamCodeController,
                    hintText: 'Enter team code',
                    color: Colors.white70,
                  ),
                ),
                subtitle: KCustomButton(
                  onTap: onJoinTeam,
                  color: accentColor,
                  child: Obx(
                    () => Visibility(
                      visible: !myCtrl.showLoading.value,
                      replacement:
                          const CircularProgressIndicator(color: Colors.white),
                      child: const KMyText('Join Team', color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
