import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:myapp/model/created_teams.dart';
import 'package:myapp/model/joined_teams.dart';
import 'package:myapp/model/tasks.dart';
import 'package:myapp/model/user_data.dart';
import 'package:myapp/services/firebase_services.dart';

late Box localData;
late MyController myCtrl;
late FirebaseServices services;

class MyController extends GetxController {
  var showLoading = false.obs;
  var userData = UserData().obs;
  var joinedTeams = JoinedTeams().obs;
  var createdTeams = CreatedTeams().obs;
  var tasks = Tasks().obs;
  var activeIndex = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
