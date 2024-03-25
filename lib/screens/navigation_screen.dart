import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/add_task.dart';
import 'package:myapp/components/app_bar_content.dart';
import 'package:myapp/components/drawer_content.dart';
import 'package:myapp/constants/k_bottom_bar_items.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/screens/page/my_chats.dart';
import 'package:myapp/screens/page/my_documents.dart';
import 'package:myapp/screens/page/my_progress.dart';
import 'package:myapp/screens/page/my_tasks.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const MyTasks(),
      const MyChats(),
      const MyDocuments(),
      const MyProgress()
    ];
    myCtrl.isOwner.value = myCtrl.currentTeam.value.ownerId ==
        FirebaseAuth.instance.currentUser!.uid;

    myCtrl.activeIndex.value = 0;

    return Scaffold(
      floatingActionButton: const AddTask(),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const AppBarContent(),
        iconTheme: const IconThemeData(color: accentColor),
      ),
      drawer: const Drawer(backgroundColor: cardColor, child: DrawerContent()),
      body: Obx(() => pages[myCtrl.activeIndex.value]),
      bottomNavigationBar: Obx(
        () => SalomonBottomBar(
          unselectedItemColor: cardColor,
          margin: const EdgeInsets.all(5),
          items: kBottomBarItems(),
          currentIndex: myCtrl.activeIndex.value,
          onTap: (index) => myCtrl.activeIndex.value = index,
          selectedItemColor: accentColor,
        ),
      ),
    );
  }
}
