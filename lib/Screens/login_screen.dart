import 'profile_screen.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:email_validator/email_validator.dart';
import '../services/auth_services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) => Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/login_bottom.png",
                  width: size.width * 0.4,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: size.height * 0.02),
                    SvgPicture.asset(
                      "assets/icons/login.svg",
                      height: size.height * 0.2,
                    ),
                    SizedBox(height: size.height * 0.1),
                    Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: TextFormField(
                              controller: emailController,
                              validator: (value) =>
                                  EmailValidator.validate(value)
                                      ? null
                                      : "Please enter a valid email",
                              onChanged: (value) {},
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: kPrimaryColor,
                                ),
                                hintText: "Email",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: kPrimaryLightColor,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: _passwordVisible,
                              onChanged: (text) {},
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                hintText: "Password",
                                icon: Icon(
                                  Icons.lock,
                                  color: kPrimaryColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: size.width * 0.9,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(29),
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                color: kPrimaryColor,
                                onPressed: () async {
                                  if (emailController.text.trim().length == 0) {
                                    return Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text("Please Enter Email Address"),
                                        backgroundColor: Color(0xff092E34),
                                      ),
                                    );
                                  } else if (passwordController.text
                                          .trim()
                                          .length ==
                                      0) {
                                    return Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Please Enter Password"),
                                        backgroundColor: Color(0xff092E34),
                                      ),
                                    );
                                  } else {
                                    await context
                                        .read<AuthenticationService>()
                                        .signIn(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                        )
                                        .then(
                                      (value) {
                                        print(value);
                                        if (value == "user-not-found") {
                                          print("User not found");
                                          return Scaffold.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text("User Not Found"),
                                              backgroundColor:
                                                  Color(0xff092E34),
                                            ),
                                          );
                                        } else if (value == "wrong-password") {
                                          print("Wrong password");
                                          return Scaffold.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text("Wrong Password"),
                                              backgroundColor:
                                                  Color(0xff092E34),
                                            ),
                                          );
                                        } else {
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Profile()));
                                        }
                                      },
                                    );
                                  }
                                },
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
