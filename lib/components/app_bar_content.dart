import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:toast/toast.dart';

class AppBarContent extends StatelessWidget {
  const AppBarContent({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Obx(
      () => ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: KMyText(
          myCtrl.currentTeam.value.teamName!,
          weight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: KMyText(
          myCtrl.currentTeam.value.projectName!,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Visibility(
          visible: myCtrl.isOwner.value,
          child: Chip(
            backgroundColor: cardColor,
            label: KMyText(myCtrl.currentTeam.value.teamCode!),
            deleteButtonTooltipMessage: 'Copy Code',
            materialTapTargetSize: MaterialTapTargetSize.padded,
            onDeleted: () => Clipboard.setData(
              ClipboardData(text: myCtrl.currentTeam.value.teamCode!),
            ).then(
              (value) => Toast.show(
                'Code copied to clipboard',
                gravity: Toast.center,
                duration: 2,
              ),
            ),
            deleteIcon: const Icon(Icons.copy_rounded),
          ),
        ),
      ),
    );
  }
}
