import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_custom_space.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/screens/home_screen.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
    onSelect(String teamCode) async {
      myCtrl.showLoading.value = true;
      await services.getTeamData(teamCode);
      myCtrl.isOwner.value = myCtrl.currentTeam.value.ownerId ==
          FirebaseAuth.instance.currentUser!.uid;
      debugPrint('Is OWner of this team: ${myCtrl.isOwner}');
      myCtrl.showLoading.value = false;
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: KHorizontalPadding(
          padding: 15,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greet title
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: KMyText('Hello, ${auth.currentUser!.displayName}'),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.grey,
                  ),
                ),
                const KVerticalSpace(),
                //Create/Join team button
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
                // Create team text
                const KMyText(
                  'Your created teams',
                  color: accentColor,
                  weight: FontWeight.bold,
                  size: 20,
                ),
                for (var i = 0; i < myCtrl.createdTeams.length; i++)
                  Obx(
                    () => InkWell(
                      onTap: () async {
                        await onSelect(myCtrl.createdTeams[i].teamCode!);
                        myCtrl.currentTeamCode.value =
                            myCtrl.createdTeams[i].teamCode!;
                        Get.back();
                      },
                      child: Chip(
                        label: KMyText(myCtrl.createdTeams[i].teamName!),
                        backgroundColor: Colors.white70,
                        deleteIcon: const Icon(
                          Icons.delete_forever,
                          color: Colors.redAccent,
                        ),
                        onDeleted: () {},
                      ),
                    ),
                  ),
                const KVerticalSpace(),
                // Joined team text
                const KMyText(
                  'Your joined teams',
                  color: accentColor,
                  weight: FontWeight.bold,
                  size: 20,
                ),
                for (var i = 0; i < myCtrl.joinedTeams.length; i++)
                  Obx(
                    () => InkWell(
                      onTap: () async {
                        await onSelect(myCtrl.joinedTeams[i].teamCode!);
                        myCtrl.currentTeamCode.value =
                            myCtrl.joinedTeams[i].teamCode!;
                        Get.back();
                      },
                      child: Chip(
                        label: KMyText(myCtrl.joinedTeams[i].teamName!),
                        backgroundColor: Colors.white70,
                        deleteButtonTooltipMessage: 'Leave',
                        deleteIcon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.redAccent,
                        ),
                        onDeleted: () {},
                      ),
                    ),
                  ),
                const KVerticalSpace(),
                const Spacer(),
                // Logout button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {},
                  label: const KMyText('Logout', color: backgroundColor),
                  icon: const Icon(Icons.logout, color: backgroundColor),
                ),
                const KVerticalSpace(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
