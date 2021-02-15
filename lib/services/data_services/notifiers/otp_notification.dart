import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// loads home, events, projects, team
class LoadOTPData extends ChangeNotifier {
  var otp;
  LoadOTPData();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference databaseRef = FirebaseDatabase().reference();

  void loadOTP() {
    try {
      final User user = auth.currentUser;
      final uid = user.uid;
      databaseRef.child('otp').child(uid).onValue.listen((event) {
        otp = event.snapshot.value;
        notifyListeners();
      }).onError((err) {
        print('Error Loading Home Data : ' + err.toString());
      });
    } catch (e) {
      final uid = "T2IOXmFYANXDE1f8PfpD6ArgI0m1";
      databaseRef.child('prescription').child(uid).onValue.listen((event) {
        otp = event.snapshot.value;
        notifyListeners();
      }).onError((err) {
        print('Error Loading Home Data : ' + err.toString());
      });
    }
  }
}
