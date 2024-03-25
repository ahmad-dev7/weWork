import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_custom_space.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/constants/k_team_chip.dart';
import 'package:myapp/constants/k_title_chip.dart';
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
    var auth = FirebaseAuth.instance;
    onSelect(String teamCode) async {
      myCtrl.showLoading.value = true;
      await services.getTeamData(teamCode);
      myCtrl.isOwner.value = myCtrl.currentTeam.value.ownerId ==
          FirebaseAuth.instance.currentUser!.uid;
      debugPrint('Is OWner of this team: ${myCtrl.isOwner}');
      myCtrl.showLoading.value = false;
    }

    onLogout() {
      myCtrl.userData.value = UserData();
      myCtrl.createdTeams.value = <CreatedTeams>[];
      myCtrl.joinedTeams.value = <JoinedTeams>[];
      myCtrl.currentTeam.value = Teams();
      localData.clear();
      myCtrl.dispose();
      Get.offAll(() => const LoginScreen());
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
                const KTitleChip(
                  label: 'My Created times',
                  iconData: Icons.person,
                ),
                for (var i = 0; i < myCtrl.createdTeams.length; i++)
                  KTeamChip(
                    onButtonTap: () async {
                      await onSelect(myCtrl.createdTeams[i].teamCode!);
                      myCtrl.currentTeamCode.value =
                          myCtrl.createdTeams[i].teamCode!;
                      Get.back();
                    },
                    onIconTap: () {},
                    index: i,
                    teamList: myCtrl.createdTeams,
                    iconData: Icons.delete,
                  ),

                const KVerticalSpace(),
                // Joined team text
                const KTitleChip(
                  label: 'My Joined Teams',
                  iconData: Icons.group_add,
                ),
                for (var i = 0; i < myCtrl.joinedTeams.length; i++)
                  KTeamChip(
                    onButtonTap: () async {
                      await onSelect(myCtrl.joinedTeams[i].teamCode!);
                      myCtrl.currentTeamCode.value =
                          myCtrl.joinedTeams[i].teamCode!;
                      Get.back();
                    },
                    onIconTap: () {},
                    index: i,
                    teamList: myCtrl.joinedTeams,
                    iconData: Icons.remove_circle,
                  ),

                const KVerticalSpace(),
                const Spacer(),
                // Logout button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      title: 'Are you sure!!!',
                      desc: 'You want to logout',
                      dialogType: DialogType.question,
                      reverseBtnOrder: true,
                      btnCancel: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                        ),
                        onPressed: () => Get.back(),
                        child: const KMyText('Cancel', color: backgroundColor),
                      ),
                      btnOk: TextButton(
                        onPressed: onLogout,
                        child: const KMyText(
                          'Continue',
                          color: Colors.red,
                        ),
                      ),
                    ).show();
                  },
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
