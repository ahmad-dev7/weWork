import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/teams_tab.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_custom_space.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/created_teams.dart';
import 'package:myapp/model/joined_teams.dart';
import 'package:myapp/model/teams.dart';
import 'package:myapp/model/user_data.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/login_screen.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    onLogout() {
      myCtrl.userData.value = UserData();
      myCtrl.createdTeams.value = <CreatedTeams>[];
      myCtrl.joinedTeams.value = <JoinedTeams>[];
      myCtrl.currentTeam.value = Teams();
      localData.clear();
      Get.offAll(() => const LoginScreen());
      myCtrl.dispose();
    }

    var devicePadding = MediaQuery.of(context).padding;
    return SafeArea(
      child: SingleChildScrollView(
        child: KHorizontalPadding(
          padding: 15,
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                (devicePadding.top + devicePadding.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greet title
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: KMyText('Hello, ${myCtrl.currentUser!.displayName}'),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                ),
                const KVerticalSpace(),
                // Create/Join button
                ElevatedButton(
                  onPressed: () {
                    localData.clear();
                    Get.to(() => const HomeScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                  ),
                  child: const KMyText(
                    'Create/Join Team',
                    color: backgroundColor,
                  ),
                ),
                const KVerticalSpace(),
                //* Created and Joined Teams tabs
                const TeamsTab(),
                const Spacer(),
                //! Logout button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Get.snackbar(
                      'Are you sure!',
                      'You want to logout?',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: backgroundColor,
                      isDismissible: true,
                      duration: const Duration(seconds: 5),
                      margin: const EdgeInsets.all(0),
                      mainButton: TextButton(
                        onPressed: null,
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: onLogout,
                              child: const KMyText(
                                'Logout',
                                color: Colors.red,
                              ),
                            ),
                            const KHorizontalSpace(width: 30),
                            TextButton(
                              onPressed: () => Get.closeAllSnackbars(),
                              child:
                                  const KMyText('Cancel', color: accentColor),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  label: const KMyText('Logout', color: backgroundColor),
                  icon: const Icon(Icons.logout, color: backgroundColor),
                ),
                const KVerticalSpace(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
