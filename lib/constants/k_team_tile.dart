import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';

class KTeamTile extends StatelessWidget {
  final int index;
  final List teamList;
  final IconData iconData;
  const KTeamTile({
    super.key,
    required this.iconData,
    required this.index,
    required this.teamList,
  });

  @override
  Widget build(BuildContext context) {
    onSelect(String teamCode) async {
      myCtrl.showLoading.value = true;
      await services.getTeamData(teamCode);
      myCtrl.isOwner.value =
          myCtrl.currentTeam.value.ownerId == currentUser!.uid;
      debugPrint('Is OWner of this team: ${myCtrl.isOwner}');
      myCtrl.showLoading.value = false;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Obx(
        () => Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: teamList[index].teamCode! == myCtrl.currentTeamCode.value
                ? accentColor.withOpacity(0.8)
                : cardColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            onTap: () async {
              await onSelect(teamList[index].teamCode!);
              myCtrl.currentTeamCode.value = teamList[index].teamCode!;
              Get.back();
            },
            contentPadding: const EdgeInsets.fromLTRB(8, 0, 5, 5),
            iconColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            minVerticalPadding: 0,
            dense: true,
            visualDensity: const VisualDensity(vertical: -3),
            title: KMyText(teamList[index].teamName!,
                color: teamList[index].teamCode! == myCtrl.currentTeamCode.value
                    ? backgroundColor
                    : Colors.black),
            subtitle: KMyText(teamList[index].projectName!,
                color: teamList[index].teamCode! == myCtrl.currentTeamCode.value
                    ? backgroundColor
                    : Colors.black),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
          ),
        ),
      ),
    );
  }
}
