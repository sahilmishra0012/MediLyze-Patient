import 'dart:ui';
import 'package:MedilyzePatient/Screens/prescription_screen.dart';
import 'package:MedilyzePatient/Screens/pathology_screen.dart';

import 'package:flutter/material.dart';
import '../constants/Theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../services/data_services/notifiers/appointment_data.dart';

import 'package:shimmer/shimmer.dart';

import '../widgets/navbar.dart';
import '../widgets/drawer.dart';

class AppointmentHistory extends StatefulWidget {
  @override
  _AppointmentHistoryState createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LoadAppointmentData>(context).loadAppointments();
    try {
      return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "Prescriptions",
          transparent: true,
        ),
        backgroundColor: ArgonColors.primary,
        drawer: ArgonDrawer(currentPage: "Prescriptions"),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Provider.of<LoadAppointmentData>(context).appointments != null
                ? Column(
                    children: [
                      Container(
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverFixedExtentList(
                              itemExtent: 150.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  try {
                                    return Container(
                                      alignment: Alignment.center,
                                      child: Card(
                                        child: InkWell(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(MdiIcons.calendar,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadAppointmentData>(
                                                                context)
                                                            .appointments[Provider.of<
                                                                            LoadAppointmentData>(
                                                                        context)
                                                                    .appointments
                                                                    .length -
                                                                1 -
                                                                index]
                                                            .keys
                                                            .elementAt(0),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(MdiIcons.doctor,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadAppointmentData>(
                                                                context)
                                                            .appointments[Provider.of<
                                                                            LoadAppointmentData>(
                                                                        context)
                                                                    .appointments
                                                                    .length -
                                                                1 -
                                                                index]
                                                            .values
                                                            .elementAt(
                                                                0)[0]['doctor'],
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(MdiIcons.hospitalBox,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadAppointmentData>(
                                                                context)
                                                            .appointments[Provider.of<
                                                                            LoadAppointmentData>(
                                                                        context)
                                                                    .appointments
                                                                    .length -
                                                                1 -
                                                                index]
                                                            .values
                                                            .elementAt(
                                                                0)[0]['hospital'],
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          MdiIcons.emoticonSick,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadAppointmentData>(
                                                                context)
                                                            .appointments[Provider.of<
                                                                            LoadAppointmentData>(
                                                                        context)
                                                                    .appointments
                                                                    .length -
                                                                1 -
                                                                index]
                                                            .values
                                                            .elementAt(
                                                                0)[0]['diagnosis'],
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              elevation: 2),
                                                      onPressed: () {
                                                        Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Prescription(
                                                          index: index)),
                                            );
                                                      },
                                                      child:
                                                          Text('Prescription'),
                                                    ),
                                                    SizedBox(width: 30.0),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              elevation: 2),
                                                      onPressed: () {Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Pathology(
                                                          index: index)),
                                            );},
                                                      child:
                                                          Text('Reports'),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            height: 400,
                                            width: double.maxFinite,
                                          ),
                                          onTap: () {
                                            
                                          },
                                        ),
                                        elevation: 5,
                                      ),
                                    );
                                  } catch (e) {
                                    return Container();
                                  }
                                },
                                childCount:
                                    Provider.of<LoadAppointmentData>(context)
                                        .appointments
                                        .length,
                              ),
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: 1000,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12),
                      Container(
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverFixedExtentList(
                              itemExtent: 150.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  try {
                                    return Container(
                                      alignment: Alignment.center,
                                      child: Card(
                                        child: GestureDetector(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                SizedBox(height: 10.0),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(MdiIcons.calendar,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadAppointmentData>(
                                                                context)
                                                            .appointments[Provider.of<
                                                                            LoadAppointmentData>(
                                                                        context)
                                                                    .appointments
                                                                    .length -
                                                                1 -
                                                                index]
                                                            .keys
                                                            .elementAt(0),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(MdiIcons.doctor,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadAppointmentData>(
                                                                context)
                                                            .appointments[Provider.of<
                                                                            LoadAppointmentData>(
                                                                        context)
                                                                    .appointments
                                                                    .length -
                                                                1 -
                                                                index]
                                                            .values
                                                            .elementAt(
                                                                0)[0]['doctor'],
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Container(
                                                    padding: EdgeInsets.only(
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
                                                            size: 22.0),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                          Provider.of<LoadAppointmentData>(
                                                                  context)
                                                              .appointments[Provider.of<
                                                                              LoadAppointmentData>(
                                                                          context)
                                                                      .appointments
                                                                      .length -
                                                                  1 -
                                                                  index]
                                                              .values
                                                              .elementAt(
                                                                  0)[0]['hospital'],
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      ],
                                                    )),
                                                SizedBox(height: 5.0),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          MdiIcons.emoticonSick,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadAppointmentData>(
                                                                context)
                                                            .appointments[Provider.of<
                                                                            LoadAppointmentData>(
                                                                        context)
                                                                    .appointments
                                                                    .length -
                                                                1 -
                                                                index]
                                                            .values
                                                            .elementAt(
                                                                0)[0]['diagnosis'],
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                              ],
                                            ),
                                            height: 220,
                                            width: double.maxFinite,
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
                                childCount:
                                    Provider.of<LoadAppointmentData>(context)
                                        .appointments
                                        .length,
                              ),
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: 1000,
                      ),
                    ],
                  ),
          ],
        ),
      );
    } catch (e) {
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "Prescriptions",
          transparent: true,
        ),
        backgroundColor: ArgonColors.bgColorScreen,
        drawer: ArgonDrawer(currentPage: "Prescriptions"),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/images/profile-screen-bg.jpg"),
                    fit: BoxFit.fitHeight),
              ),
            ),
            Provider.of<LoadAppointmentData>(context).appointments != null
                ? Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12),
                      Container(
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverFixedExtentList(
                              itemExtent: 150.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  try {
                                    return Container(
                                      alignment: Alignment.center,
                                      child: Card(
                                        child: GestureDetector(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                SizedBox(height: 10.0),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(MdiIcons.calendar,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadAppointmentData>(
                                                                context)
                                                            .appointments[Provider.of<
                                                                            LoadAppointmentData>(
                                                                        context)
                                                                    .appointments
                                                                    .length -
                                                                1 -
                                                                index]
                                                            .keys
                                                            .elementAt(0),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(MdiIcons.doctor,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadAppointmentData>(
                                                                context)
                                                            .appointments[Provider.of<
                                                                            LoadAppointmentData>(
                                                                        context)
                                                                    .appointments
                                                                    .length -
                                                                1 -
                                                                index]
                                                            .values
                                                            .elementAt(
                                                                0)[0]['doctor'],
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Container(
                                                    padding: EdgeInsets.only(
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
                                                            size: 22.0),
                                                        SizedBox(width: 10.0),
                                                        Text(
                                                          Provider.of<LoadAppointmentData>(
                                                                  context)
                                                              .appointments[Provider.of<
                                                                              LoadAppointmentData>(
                                                                          context)
                                                                      .appointments
                                                                      .length -
                                                                  1 -
                                                                  index]
                                                              .values
                                                              .elementAt(
                                                                  0)[0]['hospital'],
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      ],
                                                    )),
                                                SizedBox(height: 5.0),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                          MdiIcons.emoticonSick,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadAppointmentData>(
                                                                context)
                                                            .appointments[Provider.of<
                                                                            LoadAppointmentData>(
                                                                        context)
                                                                    .appointments
                                                                    .length -
                                                                1 -
                                                                index]
                                                            .values
                                                            .elementAt(
                                                                0)[0]['diagnosis'],
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                              ],
                                            ),
                                            height: 220,
                                            width: double.maxFinite,
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
                                childCount:
                                    Provider.of<LoadAppointmentData>(context)
                                        .appointments
                                        .length,
                              ),
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 0.86,
                        width: 1000,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12),
                      Container(
                        child: CustomScrollView(
                          slivers: <Widget>[
                            SliverFixedExtentList(
                              itemExtent: 150.0,
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                try {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Card(
                                      child: GestureDetector(
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              SizedBox(height: 10.0),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 16.0,
                                                  right: 16.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(MdiIcons.calendar,
                                                        color:
                                                            ArgonColors.initial,
                                                        size: 22.0),
                                                    SizedBox(width: 10.0),
                                                    Text(
                                                      Provider.of<LoadAppointmentData>(
                                                              context)
                                                          .appointments[Provider
                                                                      .of<LoadAppointmentData>(
                                                                          context)
                                                                  .appointments
                                                                  .length -
                                                              1 -
                                                              index]
                                                          .keys
                                                          .elementAt(0),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 16.0,
                                                  right: 16.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(MdiIcons.doctor,
                                                        color:
                                                            ArgonColors.initial,
                                                        size: 22.0),
                                                    SizedBox(width: 10.0),
                                                    Text(
                                                      Provider.of<LoadAppointmentData>(
                                                              context)
                                                          .appointments[Provider
                                                                      .of<LoadAppointmentData>(
                                                                          context)
                                                                  .appointments
                                                                  .length -
                                                              1 -
                                                              index]
                                                          .values
                                                          .elementAt(
                                                              0)[0]['doctor'],
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              Container(
                                                  padding: EdgeInsets.only(
                                                    left: 16.0,
                                                    right: 16.0,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(MdiIcons.hospitalBox,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        Provider.of<LoadAppointmentData>(
                                                                context)
                                                            .appointments[Provider.of<
                                                                            LoadAppointmentData>(
                                                                        context)
                                                                    .appointments
                                                                    .length -
                                                                1 -
                                                                index]
                                                            .values
                                                            .elementAt(
                                                                0)[0]['hospital'],
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  )),
                                              SizedBox(height: 5.0),
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: 16.0,
                                                  right: 16.0,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(MdiIcons.emoticonSick,
                                                        color:
                                                            ArgonColors.initial,
                                                        size: 22.0),
                                                    SizedBox(width: 10.0),
                                                    Text(
                                                      Provider.of<LoadAppointmentData>(
                                                              context)
                                                          .appointments[Provider
                                                                      .of<LoadAppointmentData>(
                                                                          context)
                                                                  .appointments
                                                                  .length -
                                                              1 -
                                                              index]
                                                          .values
                                                          .elementAt(
                                                              0)[0]['diagnosis'],
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                            ],
                                          ),
                                          height: 220,
                                          width: double.maxFinite,
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
                              }, childCount: 1),
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 0.86,
                        width: 1000,
                      ),
                    ],
                  ),
          ],
        ),
      );
    }
  }
}
