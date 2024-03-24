import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/members.dart';

class AssignedToPicker extends StatelessWidget {
  const AssignedToPicker({super.key});

  @override
  Widget build(BuildContext context) {
    var items = <FocusedMenuItem>[
      FocusedMenuItem(
        onPressed: () {},
        title: const KMyText('Assign to', color: backgroundColor),
        backgroundColor: accentColor,
        trailingIcon: const Icon(Icons.assignment_add, color: backgroundColor),
      ),
    ];
    for (var member in myCtrl.currentTeam.value.members!) {
      items.add(
        FocusedMenuItem(
          title: KMyText(member.name!),
          onPressed: () => myCtrl.assignTo.value = Members(
            name: member.name,
            userId: member.userId,
          ),
        ),
      );
    }
    return Expanded(
      flex: 2,
      child: FocusedMenuHolder(
        onPressed: () {},
        openWithTap: true,
        menuItems: items,
        menuWidth: MediaQuery.of(context).size.width / 2,
        menuBoxDecoration: const BoxDecoration(color: cardColor),
        child: Obx(
          () => Container(
            height: 50,
            decoration: BoxDecoration(
                color: myCtrl.assignTo.value.name == 'Assign to'
                    ? backgroundColor.withOpacity(0.6)
                    : backgroundColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: ListTile(
              title: KMyText(myCtrl.assignTo.value.name!),
              trailing: const Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ),
    );
  }
}
