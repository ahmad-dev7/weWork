import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:myapp/model/created_teams.dart';
import 'package:myapp/model/joined_teams.dart';
import 'package:myapp/model/members.dart';
import 'package:myapp/model/teams.dart';
import 'package:myapp/model/user_data.dart';
import 'package:myapp/services/firebase_services.dart';

late Box localData;
late MyController myCtrl;
late FirebaseServices services;

class MyController extends GetxController {
  var showLoading = false.obs;
  var activeIndex = 0.obs;
  var userData = UserData().obs;
  var joinedTeams = <JoinedTeams>[].obs;
  var createdTeams = <CreatedTeams>[].obs;

  //* These variables will change on team selection
  var currentTeamCode = ''.obs;
  var currentTeam = Teams().obs;
  var isOwner = false.obs;
  var assignTo = Members(name: 'Assigned To', userId: '').obs;
  var dueDate = 'Due Date'.obs;

  @override
  void onInit() {
    //TODO:
    super.onInit();
  }
}
