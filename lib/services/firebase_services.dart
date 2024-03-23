import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:myapp/constants/k_generate_code.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/created_teams.dart';
import 'package:myapp/model/joined_teams.dart';
import 'package:myapp/model/user_data.dart';

class FirebaseServices {
  // Collections
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

        if (createdTeams.length > 0) {
          myCtrl.userData.value.createdTeams = <CreatedTeams>[];
          for (var createdTeam in createdTeams) {
            myCtrl.userData.value.createdTeams!.add(
              CreatedTeams.fromJson(createdTeam),
            );
          }
        }

        if (joinedTeams.length > 0) {
          myCtrl.userData.value.joinedTeams = <JoinedTeams>[];
          for (var joinedTeam in joinedTeams) {
            myCtrl.userData.value.joinedTeams!.add(
              JoinedTeams.fromJson(joinedTeam),
            );
          }
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

      var query = await userData
          .where('userId', isEqualTo: auth.currentUser!.uid)
          .get();

      var userDoc = query.docs.first;
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
      print("---------------------- user id is assigned");
      var createdTeamData = teamsSnapshot.docs.first.data()['createdTeams'];

      myCtrl.userData.value.createdTeams = <CreatedTeams>[];

      print("---------------------- list of created teams assigned");
      for (var createdTeam in createdTeamData) {
        myCtrl.userData.value.createdTeams!.add(
          CreatedTeams.fromJson(createdTeam),
        );
        print("---------------------- inserted created team");
      }
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
        myCtrl.userData.value.joinedTeams = <JoinedTeams>[];
        for (var joinedTeam in joinedTeamData) {
          myCtrl.userData.value.joinedTeams!.add(
            JoinedTeams.fromJson(joinedTeam),
          );
        }

        return [true, 'Joined team successfully'];
      } else {
        return [false, 'You are already in this team'];
      }
    } catch (e) {
      print(e);
      return [false, "Failed to join team"];
    }
  }
}
