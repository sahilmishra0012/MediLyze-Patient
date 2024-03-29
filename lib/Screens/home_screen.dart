import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/Theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../services/data_services/notifiers/home_data.dart';
import '../services/data_services/notifiers/appointment_data.dart';
import '../services/data_services/notifiers/otp_notification.dart';
import '../services/data_services/modifiers/remove_otp.dart';

import 'package:shimmer/shimmer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../widgets/navbar.dart';
import '../widgets/drawer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializeNotifications();
  }

  initializeNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text("OTP is still on"),
          content: Text("Disable this OTP"),
          actions: [
            FlatButton(
              child: Text("Yes"),
              onPressed: () async {
                await flutterLocalNotificationsPlugin.cancel(0);
                deleteOTP();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ]),
    );
  }

  Future _showNotification(String data) async {
    var androidDetails = new AndroidNotificationDetails(
        "Patient Application", "OTP Notification", "LoginOTP",
        importance: Importance.max, priority: Priority.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    await flutterLocalNotificationsPlugin.show(0, "Login OTP",
        "Your confidential Login OTP is " + data, generalNotificationDetails,
        payload: "Task");
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LoadHomeData>(context).loadHomeData();
    Provider.of<LoadAppointmentData>(context).loadAppointments();
    Provider.of<LoadOTPData>(context).loadOTP();

    if (Provider.of<LoadOTPData>(context).otp != null) {
      print(Provider.of<LoadOTPData>(context).otp['otp']);
      _showNotification(
          Provider.of<LoadOTPData>(context).otp['otp'].toString());
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "Home",
        transparent: true,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Home"),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage("assets/images/profile-screen-bg.png"),
                  fit: BoxFit.fitWidth),
            ),
          ),
          Provider.of<LoadHomeData>(context).data != null
              ? Container(
                  child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 74.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Card(
                                      semanticContainer: true,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 1.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 85.0, bottom: 20.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Align(
                                                    child: Text(
                                                      Provider.of<LoadHomeData>(
                                                                      context)
                                                                  .data[
                                                              'firstName'] +
                                                          " " +
                                                          Provider.of<LoadHomeData>(
                                                                      context)
                                                                  .data[
                                                              'middleName'] +
                                                          " " +
                                                          Provider.of<LoadHomeData>(
                                                                  context)
                                                              .data['lastName'],
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 28.0),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Provider.of<LoadHomeData>(
                                                                          context)
                                                                      .data[
                                                                  'gender'] ==
                                                              'male'
                                                          ? Icon(
                                                              MdiIcons
                                                                  .genderMale,
                                                              color: ArgonColors
                                                                  .initial,
                                                              size: 22.0)
                                                          : Provider.of<LoadHomeData>(
                                                                              context)
                                                                          .data[
                                                                      'name'] ==
                                                                  'female'
                                                              ? Icon(
                                                                  MdiIcons
                                                                      .genderFemale,
                                                                  color: ArgonColors
                                                                      .initial,
                                                                  size: 22.0)
                                                              : Icon(
                                                                  MdiIcons
                                                                      .genderTransgender,
                                                                  color: ArgonColors
                                                                      .initial,
                                                                  size: 22.0),
                                                      SizedBox(width: 10.0),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(MdiIcons.phone,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadHomeData>(
                                                                context)
                                                            .data['phone'],
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    50,
                                                                    50,
                                                                    93,
                                                                    1),
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(MdiIcons.emailBox,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadHomeData>(
                                                                context)
                                                            .data['email'],
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    50,
                                                                    50,
                                                                    93,
                                                                    1),
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w200),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 32.0,
                                                            right: 32.0),
                                                  ),
                                                  SizedBox(height: 15.0),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  FractionalTranslation(
                                    translation: Offset(0.0, -0.5),
                                    child: Align(
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                            "assets/images/border.png"),
                                        radius: 70.0,
                                        // maxRadius: 200.0,
                                      ),
                                      alignment: FractionalOffset(0.5, 0.0),
                                    ),
                                  ),
                                  FractionalTranslation(
                                    translation: Offset(0.0, -0.5),
                                    child: Align(
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            Provider.of<LoadHomeData>(context)
                                                .data['imageUrl']),
                                        radius: 60.0,
                                        // maxRadius: 200.0,
                                      ),
                                      alignment: FractionalOffset(0.5, 0.0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.0),
                              Align(
                                child: Text("Recent Appointments",
                                    style: TextStyle(
                                        color: Color.fromRGBO(50, 50, 93, 1),
                                        fontSize: 28.0)),
                              ),
                              SizedBox(height: 15.0),
                              Provider.of<LoadAppointmentData>(context)
                                          .appointments !=
                                      null
                                  ? Container(
                                      child: CustomScrollView(
                                        slivers: <Widget>[
                                          SliverFixedExtentList(
                                            itemExtent: 150.0,
                                            delegate:
                                                SliverChildBuilderDelegate(
                                              (BuildContext context,
                                                  int index) {
                                                try {
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    child: Card(
                                                      child: InkWell(
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              SizedBox(
                                                                  height: 10.0),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 16.0,
                                                                  right: 16.0,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        MdiIcons
                                                                            .calendar,
                                                                        color: ArgonColors
                                                                            .initial,
                                                                        size:
                                                                            22.0),
                                                                    SizedBox(
                                                                        width:
                                                                            10.0),
                                                                    Text(
                                                                      Provider.of<LoadAppointmentData>(
                                                                              context)
                                                                          .appointments[Provider.of<LoadAppointmentData>(context).appointments.length -
                                                                              1 -
                                                                              index]
                                                                          .keys
                                                                          .elementAt(
                                                                              0),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 5.0),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 16.0,
                                                                  right: 16.0,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        MdiIcons
                                                                            .doctor,
                                                                        color: ArgonColors
                                                                            .initial,
                                                                        size:
                                                                            22.0),
                                                                    SizedBox(
                                                                        width:
                                                                            10.0),
                                                                    Text(
                                                                      Provider.of<LoadAppointmentData>(
                                                                              context)
                                                                          .appointments[Provider.of<LoadAppointmentData>(context).appointments.length -
                                                                              1 -
                                                                              index]
                                                                          .values
                                                                          .elementAt(
                                                                              0)[0]['doctor'],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 5.0),
                                                              Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: 16.0,
                                                                    right: 16.0,
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                          MdiIcons
                                                                              .hospitalBox,
                                                                          color: ArgonColors
                                                                              .initial,
                                                                          size:
                                                                              22.0),
                                                                      SizedBox(
                                                                          width:
                                                                              10.0),
                                                                      Text(
                                                                        Provider.of<LoadAppointmentData>(context)
                                                                            .appointments[Provider.of<LoadAppointmentData>(context).appointments.length -
                                                                                1 -
                                                                                index]
                                                                            .values
                                                                            .elementAt(0)[0]['hospital'],
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                      ),
                                                                    ],
                                                                  )),
                                                              SizedBox(
                                                                  height: 5.0),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 16.0,
                                                                  right: 16.0,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                        MdiIcons
                                                                            .emoticonSick,
                                                                        color: ArgonColors
                                                                            .initial,
                                                                        size:
                                                                            22.0),
                                                                    SizedBox(
                                                                        width:
                                                                            10.0),
                                                                    Text(
                                                                      Provider.of<LoadAppointmentData>(
                                                                              context)
                                                                          .appointments[Provider.of<LoadAppointmentData>(context).appointments.length -
                                                                              1 -
                                                                              index]
                                                                          .values
                                                                          .elementAt(
                                                                              0)[0]['diagnosis'],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 5.0),
                                                            ],
                                                          ),
                                                          height: 220,
                                                          width:
                                                              double.maxFinite,
                                                        ),
                                                        onTap: () {
                                                          print(index);
                                                        },
                                                      ),
                                                      elevation: 5,
                                                    ),
                                                  );
                                                } catch (e) {
                                                  return Container();
                                                }
                                              },
                                              childCount: Provider.of<
                                                          LoadAppointmentData>(
                                                      context)
                                                  .appointments
                                                  .length,
                                            ),
                                          ),
                                        ],
                                      ),
                                      height: 1000,
                                      width: 100,
                                    )
                                  : Container(
                                      child: Align(
                                        child: Text("No recent appointments",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    50, 50, 93, 1),
                                                fontSize: 12.0)),
                                      ),
                                      // color: Color.fromRGBO(255, 255, 255, 1),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.35,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 5,
                                            blurRadius: 20,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ]),
                )
              : Container(
                  child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 74.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Shimmer.fromColors(
                                      // Wrap your widget into Shimmer.
                                      baseColor: Colors.grey[100],
                                      highlightColor: Colors.grey[200],
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        elevation: 1.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 85.0, bottom: 20.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      child: Text("",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      50,
                                                                      50,
                                                                      93,
                                                                      1),
                                                              fontSize: 28.0)),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                          "",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      50,
                                                                      50,
                                                                      93,
                                                                      1),
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                          "",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      50,
                                                                      50,
                                                                      93,
                                                                      1),
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                          "",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      50,
                                                                      50,
                                                                      93,
                                                                      1),
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w200),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 32.0,
                                                              right: 32.0),
                                                    ),
                                                    SizedBox(height: 30.0),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  FractionalTranslation(
                                    translation: Offset(0.0, -0.5),
                                    child: Align(
                                      child: Shimmer.fromColors(
                                        // Wrap your widget into Shimmer.
                                        baseColor: Colors.grey[200],
                                        highlightColor: Colors.grey[350],
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/profile-screen-avatar.png'),
                                          radius: 70.0,
                                          // maxRadius: 200.0,
                                        ),
                                      ),
                                      alignment: FractionalOffset(0.5, 0.0),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.0),
                              Align(
                                child: Text("Recent Appointments",
                                    style: TextStyle(
                                        color: Color.fromRGBO(50, 50, 93, 1),
                                        fontSize: 28.0)),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                child: CustomScrollView(
                                  slivers: <Widget>[
                                    SliverFixedExtentList(
                                      itemExtent: 100.0,
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          try {
                                            return Shimmer.fromColors(
                                              baseColor: Colors.grey[100],
                                              highlightColor: Colors.grey[200],
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Card(
                                                  child: GestureDetector(
                                                    child: Container(
                                                      child: Text(
                                                          index.toString()),
                                                      height: 220,
                                                      width: double.maxFinite,
                                                    ),
                                                    onTap: () {
                                                      print(index);
                                                    },
                                                  ),
                                                  elevation: 5,
                                                ),
                                              ),
                                            );
                                          } catch (e) {
                                            return Container();
                                          }
                                        },
                                        childCount: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                height: 1000,
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                      ]),
                )
        ],
      ),
    );
  }
}
