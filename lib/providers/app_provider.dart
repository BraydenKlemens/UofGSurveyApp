import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:survey_app/models/load_data.dart';

import '../models/survey.dart';


class AppProvider extends ChangeNotifier {

  //AUTH VARS ----------------------------------------------------------------------------------------
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool signedIn = false;
  User? currentUser;
  String? get name => currentUser?.displayName;

  //APP VARS ----------------------------------------------------------------------------------------
  bool showAuth = false;
  bool showCompleted = false;

  //FIRESTORE VARS ----------------------------------------------------------------------------------------
  List userData = LoadData.userData;
  List loadUserSurveys = [];
  List<Survey> surveys = [];
  List<Survey> completeSurveys = [];
  List<Survey> history = [];


  //AUTH FUNCTIONS ----------------------------------------------------------------------------------------

  //SIGN UP METHOD - all auth methods return strings for error handling
  Future<String?> signUp({required String email, required String password, required String name}) async {
    try {
      await firebaseAuth
        .createUserWithEmailAndPassword(
          email: email,
          password: password
        );
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      currentUser = FirebaseAuth.instance.currentUser;
      initUser();
      showAuth = false;
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
  
  //SIGN IN METHOD
  Future<String?> signIn({required String email, required String password}) async {
    try {
      await firebaseAuth
        .signInWithEmailAndPassword(
          email: email,
          password: password
        );
      currentUser = FirebaseAuth.instance.currentUser;
      showAuth = false;
      getSurveys();
      getCompletedSurveys();
      getHistory();
      return "Signed in!";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
  
  //SIGN OUT METHOD
  void signOut() {
    //clear lists and log out
    loadUserSurveys = [];
    surveys = [];
    completeSurveys = [];
    history = [];
    firebaseAuth.signOut();
  }

  void deleteAccout() {
    //clear lists and delete
    loadUserSurveys = [];
    surveys = [];
    completeSurveys = [];
    history = [];
    addDeletedUserToFireStore();
    FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.email)
      .delete();
    FirebaseAuth.instance.currentUser!.delete();
  }

  //FIRESTORE FUNCTIONS  -----------------------------------------------------------------------------

  //Create a user collection on firestore
  Future<void> addUserToFireStore() {
    return FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.email)
      .set(<String, dynamic>{
        'name': currentUser!.displayName,
        'email': currentUser!.email,
        'uid': currentUser!.uid,
        'surveys': [],
        'surveyscomplete': [],
        'allsurveys': [],
        'history': [],
    });
  }

  Future<void> addDeletedUserToFireStore() {
    return FirebaseFirestore.instance
      .collection('deletedusers')
      .doc(currentUser!.email)
      .set(<String, dynamic>{
        'name': currentUser!.displayName,
        'email': currentUser!.email,
        'uid': currentUser!.uid,
        'deletionTime': DateTime.now()
    });
  }

  void initUser() {
    addUserToFireStore();
    getUserData();
    loadUserData();
    getSurveys();
  }

  //get data from the all users array
  void getUserData(){
    for(var i in userData){
      if(i['user'] == currentUser!.email){
        loadUserSurveys = i['surveys'];
      }
    }
  }

  //Gets the all the surveys the user should have from the json file
  Future<void> loadUserData(){
    //save to the firestore
    return FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.email)
      .update({'surveys': loadUserSurveys, 'allsurveys': loadUserSurveys})
      .then((value) => loadUserSurveys = []);
  }

  //check for new surveys added to the users profile
  void updateUserData() {
    surveys = [];
    completeSurveys = [];
    getSurveys();
    getCompletedSurveys();
  }

  //get all the surveys for a particular user
  Future<void> getSurveys() {
    return FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.email)
      .get()
      .then((value) {
        for(var s in value['surveys']){
          surveys.add(Survey(title: s['title'] as String, url: s['url'] as String, date: DateTime.now()));
        }
        notifyListeners();
      });
  }

  //Load all surveys complete for a user after signing in
  Future<void> getCompletedSurveys() {
    return FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.email)
      .get()
      .then((value) {
        for(var s in value['surveyscomplete']){
          completeSurveys.add(Survey(title: s['title'] as String, url: s['url'] as String, date: DateTime.now()));
        }
        notifyListeners();
      });
  }

  Future<void> getHistory() {
    return FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.email)
      .get()
      .then((value) {
        for(var s in value['history']){
          history.add(Survey(title: s['title'] as String, url: s['url'] as String, date: DateTime.now()));
        }
        notifyListeners();
      });
  }

  //Complete Survey
  Future<void>completeSurvey(int index, Survey s) { 
    surveys.removeWhere((element) => element == s);
    if(!completeSurveys.contains(s)) {
      completeSurveys.add(Survey(title: s.title, url: s.url, date: DateTime.now()));
    }
    history.add(Survey(title: s.title, url: s.url, date: DateTime.now()));
    //add a logging history list
    notifyListeners();

    //create map function here
    return FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser!.email)
      .update({'surveys': toMap(surveys), 'surveyscomplete': toMap(completeSurveys), 'history': toMap(history)})
      .then((value) => notifyListeners());
  }

  //REGULAR APP STATE MANAGMENT ----------------------------------------------------------------------

  //Toggle authentication gate login / register page
  void changeAuth(){
    showAuth = !showAuth;
    notifyListeners();
  }

  //Toggles the show completed surveys button
  void showFilter(){
    showCompleted = !showCompleted;
    notifyListeners();
  }

  List<dynamic> toMap(List list){
    List newlist = [];
    for(var s in list){
      newlist.add(s.dictdata);
    }
    return newlist;
  }

}