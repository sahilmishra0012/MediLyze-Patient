import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// loads home, events, projects, team
class LoadHomeData extends ChangeNotifier {
  var data, appointments;
  LoadHomeData();
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('patients');
  final DatabaseReference databaseRef = FirebaseDatabase().reference();

  void loadHomeData() {
    final User user = auth.currentUser;
    final uid = user.uid;
    users.doc((uid).toString()).get().then((queryResult) {
      data = queryResult.data();
      notifyListeners();
    }).catchError((err) {
      print(err);
    });
  }

  // void loadAppointments() {
  //   databaseRef.child('master').onValue.listen((event) {
  //     appointments = event.snapshot.data();
  //     notifyListeners();
  //   }).onError((err) {
  //     print('Error Loading Home Data : ' + err.toString());
  //   });
  // }
}
