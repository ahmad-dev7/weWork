import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_bottom_bar_items.dart';
import 'package:myapp/constants/k_colors.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/screens/home_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: accentColor),
      ),
      drawer: Drawer(
        backgroundColor: cardColor,
        child: IconButton(
            onPressed: () {
              localData.clear();
              Get.to(() => const HomeScreen());
            },
            icon: const Icon(
              Icons.create_new_folder,
              color: accentColor,
            )),
      ),
      body: Obx(() => pages[myCtrl.activeIndex.value]),
      bottomNavigationBar: Obx(
        () => SalomonBottomBar(
          items: kBottomBarItems(),
          currentIndex: myCtrl.activeIndex.value,
          onTap: (index) => myCtrl.activeIndex.value = index,
          selectedItemColor: accentColor,
        ),
      ),
    );
  }
}
