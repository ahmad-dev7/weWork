import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/assigned_to_picker.dart';
import 'package:myapp/components/due_date_picker.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_custom_button.dart';
import 'package:myapp/constants/k_custom_space.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/constants/k_textfield.dart';
import 'package:myapp/controller/my_controller.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    var titleCtrl = TextEditingController();
    var descCtrl = TextEditingController();
    onCreateTask() async {
      myCtrl.showLoading.value = true;
      if (titleCtrl.text.isNotEmpty &&
          descCtrl.text.isNotEmpty &&
          myCtrl.dueDate.value != 'Due Date' &&
          myCtrl.assignTo.value.name != 'Assigned To') {
        var res = await services.createTask(
          titleCtrl.text,
          descCtrl.text,
          myCtrl.assignTo.value,
          myCtrl.dueDate.value,
        );
        if (res == true) {
          Get.back();
          Get.snackbar(
            'Success',
            'Task assigned to ${myCtrl.assignTo.value.name}',
            backgroundColor: accentColor,
          );
        } else {
          Get.snackbar(
            'Error',
            'Failed to create task',
          );
        }
      } else {
        Get.snackbar(
          'Incomplete form',
          'Please fill all fields correctly',
          backgroundColor: cardColor,
        );
      }
      myCtrl.showLoading.value = false;
    }

    return Obx(
      () => Visibility(
        visible: myCtrl.isOwner.value && myCtrl.activeIndex.value == 0,
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.bottomSheet(
              Container(
                color: cardColor,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: accentColor),
                      ),
                    ),
                    child: const KMyText(
                      "Add Task",
                      weight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                  subtitle: SingleChildScrollView(
                    child: KHorizontalPadding(
                      child: Column(
                        children: [
                          const KVerticalSpace(height: 10),
                          // Title textfield
                          KTextField(
                            color: backgroundColor.withOpacity(0.7),
                            controller: titleCtrl,
                            hintText: 'Task title',
                          ),
                          const KVerticalSpace(),
                          // Description textfield
                          KTextField(
                            color: backgroundColor.withOpacity(0.7),
                            controller: descCtrl,
                            hintText: 'Task description',
                            maxLines: 2,
                          ),
                          const KVerticalSpace(),
                          // Assign to dropdown and Due Date Picker
                          const Row(
                            children: [
                              // Assign to dropdown
                              AssignedToPicker(),

                              SizedBox(width: 20),

                              // Due Date Picker
                              DueDatePicker(),
                            ],
                          ),
                          const KVerticalSpace(),
                          //Create Task button
                          KCustomButton(
                            onTap: onCreateTask,
                            child: Obx(
                              () => Visibility(
                                visible: !myCtrl.showLoading.value,
                                replacement: const CircularProgressIndicator(
                                  color: backgroundColor,
                                ),
                                child: const KMyText(
                                  'Create Task',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const KVerticalSpace(height: 70),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              isDismissible: false,
              enableDrag: true,
              elevation: 50,
            ).then((value) {
              myCtrl.assignTo.value.name = 'Assign to';
              myCtrl.dueDate.value = 'Due Date';
            });
          },
          backgroundColor: accentColor,
          label: const KMyText('Create Task', color: backgroundColor),
          icon: const Icon(Icons.add, color: cardColor),
        ),
      ),
    );
  }
}
