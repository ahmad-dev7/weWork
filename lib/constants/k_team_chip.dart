import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/constants/k_my_text.dart';

class KTeamChip extends StatelessWidget {
  final Function() onButtonTap;
  final Function() onIconTap;
  final int index;
  final List teamList;
  final IconData iconData;
  const KTeamChip({
    super.key,
    required this.onButtonTap,
    required this.onIconTap,
    required this.iconData,
    required this.index,
    required this.teamList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Obx(
        () => ListTile(
          onTap: onButtonTap,
          enableFeedback: true,
          minVerticalPadding: 0,
          contentPadding: const EdgeInsets.only(left: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: teamList[index].teamCode == myCtrl.currentTeamCode.value
                  ? Colors.white
                  : accentColor,
              width: .5,
            ),
          ),
          tileColor: teamList[index].teamCode == myCtrl.currentTeamCode.value
              ? accentColor
              : accentColor.withOpacity(0.0),
          iconColor: teamList[index].teamCode == myCtrl.currentTeamCode.value
              ? Colors.redAccent
              : Colors.blueGrey,
          visualDensity: const VisualDensity(vertical: -4),
          title: KMyText(
            teamList[index].teamName,
            color: teamList[index].teamCode == myCtrl.currentTeamCode.value
                ? Colors.white
                : Colors.black,
          ),
          trailing: IconButton.outlined(
            padding: const EdgeInsets.all(3),
            onPressed: onIconTap,
            icon: Icon(iconData),
          ),
        ),
      ),
    );
  }
}
