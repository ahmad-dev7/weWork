import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:myapp/constants/k_generate_code.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/created_teams.dart';
import 'package:myapp/model/joined_teams.dart';
import 'package:myapp/model/members.dart';
import 'package:myapp/model/tasks.dart';
import 'package:myapp/model/teams.dart';
import 'package:myapp/model/user_data.dart';

class FirebaseServices {
  //* Collections
  var auth = FirebaseAuth.instance;
  var userData = FirebaseFirestore.instance.collection('userData');
  var allTeams = FirebaseFirestore.instance.collection('allTeams');

  //* Signup user
  Future<bool> signUp(String email, String password, String name) async {
    try {
      var credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        credential.user!.updateDisplayName(name);
        userData.add({
          'createdTeams': [],
          'joinedTeams': [],
          'name': name,
          'userId': credential.user!.uid
        });
        myCtrl.userData.value = UserData(
          name: name,
          userId: credential.user!.uid,
        );
        localData.put('name', name);
        localData.put('userId', credential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //* Login user
  Future<bool> login(String email, String password) async {
    try {
      var credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        var teamsSnapshot = await userData
            .where('userId', isEqualTo: credential.user!.uid)
            .get();

        var data = UserData.fromJson(teamsSnapshot.docs[0].data());
        myCtrl.userData.value = data;
        var createdTeams = teamsSnapshot.docs[0].data()['createdTeams'];
        var joinedTeams = teamsSnapshot.docs[0].data()['joinedTeams'];

        // Joined Teams
        if (joinedTeams.length > 0) {
          myCtrl.joinedTeams.value = <JoinedTeams>[];
          for (var joinedTeam in joinedTeams) {
            myCtrl.joinedTeams.add(
              JoinedTeams.fromJson(joinedTeam),
            );
          }
          myCtrl.currentTeamCode.value = myCtrl.joinedTeams.first.teamCode!;
          await getTeamData(myCtrl.currentTeamCode.value);
          print('-----------------------------------');
          print('called joined team with: ${myCtrl.currentTeamCode.value}');
        }

        // Created Teams
        if (createdTeams.length > 0) {
          for (var createdTeam in createdTeams) {
            myCtrl.createdTeams.add(
              CreatedTeams.fromJson(createdTeam),
            );
          }
          myCtrl.currentTeamCode.value = myCtrl.createdTeams.first.teamCode!;
          await getTeamData(myCtrl.currentTeamCode.value);
          print('-----------------------------------');
          print('called created team with: ${myCtrl.currentTeamCode.value}');
        }

        localData.put('name', credential.user!.displayName);
        localData.put('userId', credential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  //* Create Team
  Future<bool> createTeam(
    String teamName,
    String projectName,
    String projectDescription,
  ) async {
    try {
      var teamCode = generateTeamCode();
      // Created New team
      await allTeams.add({
        'teamName': teamName,
        'projectName': projectName,
        'projectDescription': projectDescription,
        'teamCode': teamCode,
        'ownerName': auth.currentUser!.displayName,
        'ownerId': auth.currentUser!.uid,
        'members': [],
        'tasks': [],
      });

      var query = await allTeams.where('teamCode', isEqualTo: teamCode).get();
      var membersDoc = query.docs.first;
      List<dynamic> members = membersDoc['members'];
      members.add({
        'name': auth.currentUser!.displayName,
        'userId': auth.currentUser!.uid,
      });

      await membersDoc.reference.update({'members': members});

      var userDataQuery = await userData
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .get();

      var userDoc = userDataQuery.docs.first;
      List<dynamic> currentData = userDoc['createdTeams'];
      currentData.add({
        'teamName': teamName,
        'projectName': projectName,
        'projectDescription': projectDescription,
        'teamCode': teamCode,
      });

      await userDoc.reference.update({'createdTeams': currentData});

      var teamsSnapshot = await userData
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .get();
      var createdTeamData = teamsSnapshot.docs.first.data()['createdTeams'];

      myCtrl.createdTeams.value = <CreatedTeams>[];
      for (var createdTeam in createdTeamData) {
        myCtrl.createdTeams.add(
          CreatedTeams.fromJson(createdTeam),
        );
      }
      myCtrl.currentTeamCode.value = teamCode;
      getTeamData(teamCode);
      Clipboard.setData(ClipboardData(text: teamCode));
      //*
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //* Join Team
  Future<List<dynamic>> joinTeam(String teamCode) async {
    try {
      var query = await allTeams.where('teamCode', isEqualTo: teamCode).get();

      var teamDoc = query.docs.first;
      bool isJoined() {
        bool isAlreadyJoined = false;
        for (var member in teamDoc['members']) {
          if (member['userId'] == auth.currentUser!.uid) {
            isAlreadyJoined = true;
            break;
          }
        }
        return isAlreadyJoined;
      }

      if (teamDoc['ownerId'] != auth.currentUser!.uid && !isJoined()) {
        var currentMembers = teamDoc['members'];
        currentMembers.add({
          'name': auth.currentUser!.displayName,
          'userId': auth.currentUser!.uid,
        });

        await teamDoc.reference.update({'members': currentMembers});

        var userDataQuery = await userData
            .where('userId', isEqualTo: auth.currentUser!.uid)
            .get();

        var userDataDoc = userDataQuery.docs.first;
        var currentData = userDataDoc['joinedTeams'];
        currentData.add({
          'teamName': teamDoc['teamName'],
          'projectName': teamDoc['projectName'],
          'projectDescription': teamDoc['projectDescription'],
          'teamCode': teamDoc['teamCode'],
          'ownerName': teamDoc['ownerName'],
        });
        await userDataDoc.reference.update({'joinedTeams': currentData});

        await Future.delayed(const Duration(milliseconds: 200));

        var teamsSnapshot = await userData
            .where('userId', isEqualTo: auth.currentUser!.uid)
            .get();

        var joinedTeamData = teamsSnapshot.docs.first['joinedTeams'];
        myCtrl.joinedTeams.value = <JoinedTeams>[];
        for (var joinedTeam in joinedTeamData) {
          myCtrl.joinedTeams.add(
            JoinedTeams.fromJson(joinedTeam),
          );
        }
        myCtrl.currentTeamCode.value = teamCode;
        await getTeamData(teamCode);
        return [true, 'Joined team successfully'];
      } else {
        return [false, 'You are already in this team'];
      }
    } catch (e) {
      print(e);
      return [false, "Failed to join team"];
    }
  }

  //* Team Data
  Future getTeamData(String teamCode) async {
    print('Reached here---------------');
    try {
      var query = await allTeams.where('teamCode', isEqualTo: teamCode).get();
      myCtrl.currentTeam.value = Teams.fromJson(query.docs.first.data());
      return;
    } catch (exception) {
      print(exception);
    }
  }

  //* Create Task
  Future<bool> createTask(String title, String description, Members assignedTo,
      String dueDate) async {
    try {
      var teamCode = myCtrl.currentTeamCode.value;
      var teamData =
          await allTeams.where('teamCode', isEqualTo: teamCode).get();

      var teamDoc = teamData.docs.first;
      var tasks = teamDoc['tasks'];

      tasks.add({
        'title': title,
        'description': description,
        'assignedTo': [
          {
            'name': assignedTo.name,
            'userId': assignedTo.userId,
          }
        ],
        'dueDate': dueDate,
        'isCompleted': false,
      });

      await teamDoc.reference.update({'tasks': tasks});

      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  //* Complete Task
  Future completeTask(int index) async {
    try {
      var query = await allTeams
          .where('teamCode', isEqualTo: myCtrl.currentTeamCode.value)
          .get();

      var taskDoc = query.docs.first;
      var currentTask = taskDoc['tasks'];
      currentTask[index]['isCompleted'] = true;
      await taskDoc.reference.update({'tasks': currentTask});
      getTeamData(myCtrl.currentTeamCode.value);
      return true;
    } catch (exception) {
      print("Caused exception: $exception");
      return false;
    }
  }

  //* Edit Task
  Future editTask(int i, Tasks task) async {
    var title = task.taskTitle ?? myCtrl.currentTeam.value.tasks![i].taskTitle!;
    var description = task.taskDescription ??
        myCtrl.currentTeam.value.tasks![i].taskDescription!;
    var assignedTo =
        task.assignedTo ?? myCtrl.currentTeam.value.tasks![i].assignedTo;
    var dueDate = task.dueDate ?? myCtrl.currentTeam.value.tasks![i].dueDate;
    var isCompleted =
        task.isCompleted ?? myCtrl.currentTeam.value.tasks![i].isCompleted;

    print('Title: ## $title');
    print('Description: ## $description');
    print('Assigned to: ## $assignedTo');
    print('Due Date: ## $dueDate');
    print('isCompleted: ## $isCompleted');

    try {
      var query = await allTeams
          .where('teamCode', isEqualTo: myCtrl.currentTeamCode.value)
          .get();

      var taskDoc = query.docs.first;
      var currentTask = taskDoc['tasks'];
      currentTask[i].add({'assignedTo': ''});
    } catch (exception) {
      print(exception);
    }
  }

  //
}
