import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/constants/k_custom_space.dart';
import 'package:myapp/constants/k_format_date.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';

class MyTasks extends StatelessWidget {
  const MyTasks({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => ListView.builder(
            itemCount: myCtrl.currentTeam.value.tasks!.length,
            itemBuilder: ((context, index) {
              var dueDate = kFormatDate(
                DateTime.fromMillisecondsSinceEpoch(
                  myCtrl.currentTeam.value.tasks![index].dueDate!.seconds *
                      1000,
                ),
              );
              return Visibility(
                visible: myCtrl.isOwner.value ||
                    myCtrl.currentTeam.value.tasks![index].assignedTo!.userId ==
                        myCtrl.currentUser!.uid,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    15,
                    10,
                    15,
                    myCtrl.currentTeam.value.tasks!.length - 1 == index
                        ? 70
                        : 10,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      // Task title and description tile
                      ListTile(
                        tileColor: Colors.transparent,
                        title: Text(
                          myCtrl.currentTeam.value.tasks![index].taskTitle!,
                        ),
                        subtitle: Text(
                          myCtrl
                              .currentTeam.value.tasks![index].taskDescription!,
                        ),
                        minLeadingWidth: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.only(left: 8),
                        titleAlignment: ListTileTitleAlignment.threeLine,
                        leading: Icon(
                          Icons.circle_notifications_outlined,
                          color: index.isEven ? Colors.red : Colors.green,
                        ),
                      ),
                      // Icons and due date tile
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Visibility(
                                visible: myCtrl.isOwner.value,
                                child: KMyText(
                                  myCtrl.currentTeam.value.tasks![index]
                                      .assignedTo!.name!,
                                ),
                              ),
                              subtitle: Text("Due Date: $dueDate"),
                            ),
                          ),
                          if (myCtrl.isOwner.value)
                            IconButton.filled(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          const KHorizontalSpace(),
                          if (myCtrl.isOwner.value)
                            IconButton.filled(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                          const KHorizontalSpace(),
                          IconButton.filled(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
