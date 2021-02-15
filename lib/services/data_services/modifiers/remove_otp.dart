import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// loads home, events, projects, team

void deleteOTP() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DatabaseReference databaseRef = FirebaseDatabase().reference();
  final User user = auth.currentUser;
  final uid = user.uid;
  databaseRef.child('otp').child(uid).remove();
}
