import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';

class DueDatePicker extends StatelessWidget {
  const DueDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    String kFormatDate(DateTime dateTime) {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }

    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: () => showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 365),
          ),
          helpText: 'Select Due Date',
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: accentColor,
                  background: cardColor,
                ),
                dialogBackgroundColor: cardColor,
              ),
              child: child!,
            );
          },
        ).then((value) =>
            value != null ? myCtrl.dueDate.value = value.toString() : ''),
        child: Obx(
          () => Container(
            height: 50,
            decoration: BoxDecoration(
                color: myCtrl.dueDate.value == 'Due Date'
                    ? backgroundColor.withOpacity(0.6)
                    : backgroundColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: ListTile(
              title: KMyText(
                myCtrl.dueDate.value == 'Due Date'
                    ? 'Due Date'
                    : kFormatDate(
                        DateTime.parse(myCtrl.dueDate.value),
                      ),
              ),
              trailing: const Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ),
    );
  }
}
