import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/services/firebase_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await Hive.initFlutter();
  localData = await Hive.openBox('localBox');
  myCtrl = Get.put(MyController());
  services = FirebaseServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: LoginScreen(),
    );
  }
}



// TODO: Task actions, on edit, on delete, on complete.
// TODO: Chat
// TODO: Documents
// TODO: Progress bar
// TODO: On leave/ Delete team
// TODO: Notify user when task is assigned to them.
