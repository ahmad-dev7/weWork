import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/constants/k_team_tile.dart';
import 'package:myapp/controller/my_controller.dart';

class TeamsTab extends StatelessWidget {
  const TeamsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Obx(
        () => ContainedTabBarView(
            initialIndex: getCurrentIndex(),
            tabBarProperties: const TabBarProperties(
              indicatorWeight: 3,
            ),
            tabs: const [
              KMyText('Created Teams'),
              KMyText('Joined Teams'),
            ],
            views: [
              //* Created Teams
              SingleChildScrollView(
                child: Column(
                  children: [
                    for (var i = 0; i < myCtrl.createdTeams.length; i++)
                      KTeamTile(
                        iconData: Icons.delete,
                        index: i,
                        teamList: myCtrl.createdTeams,
                      ),
                  ],
                ),
              ),
              //* Joined Teams
              SingleChildScrollView(
                child: Column(
                  children: [
                    for (var i = 0; i < myCtrl.joinedTeams.length; i++)
                      KTeamTile(
                        iconData: Icons.remove_circle,
                        index: i,
                        teamList: myCtrl.joinedTeams,
                      )
                  ],
                ),
              ),
            ],
            onChange: (index) => ''),
      ),
    );
  }
}

int getCurrentIndex() {
  int index = 0;
  for (var teams in myCtrl.joinedTeams) {
    if (teams.teamCode == myCtrl.currentTeamCode.value) {
      index = 1;
    }
  }
  return index;
}
