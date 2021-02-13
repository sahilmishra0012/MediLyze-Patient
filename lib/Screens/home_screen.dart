import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/const.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("HIiii"),
              RaisedButton(
                  child: Text("Sign Out"),
                  onPressed: () {
                    context.read<AuthenticationService>().signOut();
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
