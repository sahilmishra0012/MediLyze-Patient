import 'Screens/home_splash_screen.dart';
import 'services/data_services/notifiers/home_data.dart';
import 'services/data_services/notifiers/appointment_data.dart';
import 'Screens/login_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'services/auth_services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
        ChangeNotifierProvider<LoadHomeData>(create: (_) => LoadHomeData()),
        ChangeNotifierProvider<LoadAppointmentData>(
            create: (_) => LoadAppointmentData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medilyze',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    print(firebaseUser == null);
    if (firebaseUser == null) {
      return AuthSplashScreen();
    } else {
      return HomeSplashScreen();
    }
  }
}
