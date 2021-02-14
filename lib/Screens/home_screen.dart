import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/Theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../services/data_services/notifiers/home_data.dart';
import '../services/data_services/notifiers/appointment_data.dart';
import 'package:shimmer/shimmer.dart';

//widgets
import 'package:MedilyzePatient/widgets/navbar.dart';
import 'package:MedilyzePatient/widgets/drawer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Provider.of<LoadHomeData>(context).loadHomeData();
    Provider.of<LoadAppointmentData>(context).loadAppointments();

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
          Provider.of<LoadHomeData>(context).data != null &&
                  Provider.of<LoadAppointmentData>(context).appointments != null
              ? Container(
                  child: ListView(children: [
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
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
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
                                                child: Text(
                                                    Provider.of<LoadHomeData>(
                                                            context)
                                                        .data['name'],
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 28.0)),
                                              ),
                                              SizedBox(height: 10.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Provider.of<LoadHomeData>(
                                                                  context)
                                                              .data['gender'] ==
                                                          'Male'
                                                      ? Icon(
                                                          MdiIcons.genderMale,
                                                          color: ArgonColors
                                                              .initial,
                                                          size: 22.0)
                                                      : Provider.of<LoadHomeData>(
                                                                          context)
                                                                      .data[
                                                                  'name'] ==
                                                              'Female'
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
                                                  Text(
                                                    "22",
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w200),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(MdiIcons.phone,
                                                      color:
                                                          ArgonColors.initial,
                                                      size: 22.0),
                                                  SizedBox(width: 10.0),
                                                  Text(
                                                    Provider.of<LoadHomeData>(
                                                            context)
                                                        .data['phone'],
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w200),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(MdiIcons.emailBox,
                                                      color:
                                                          ArgonColors.initial,
                                                      size: 22.0),
                                                  SizedBox(width: 10.0),
                                                  Text(
                                                    Provider.of<LoadHomeData>(
                                                            context)
                                                        .data['email'],
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            50, 50, 93, 1),
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w200),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 32.0, right: 32.0),
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
                                    backgroundImage: NetworkImage(
                                        Provider.of<LoadHomeData>(context)
                                            .data['photo']),
                                    radius: 70.0,
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
                          Container(
                            child: CustomScrollView(
                              slivers: <Widget>[
                                SliverFixedExtentList(
                                  itemExtent: 100.0,
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      try {
                                        return Container(
                                          alignment: Alignment.center,
                                          child: Card(
                                            child: GestureDetector(
                                              child: Container(
                                                child: Text(Provider.of<
                                                            LoadAppointmentData>(
                                                        context)
                                                    .appointments[index]
                                                    .values
                                                    .elementAt(
                                                        0)[0]['prescription_id']),
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
                                        Provider.of<LoadAppointmentData>(
                                                context)
                                            .appointments
                                            .length,
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
              :

              // Center(
              //     child: SpinKitChasingDots(
              //       color: Colors.white,
              //       size: 50.0,
              //     ),
              //   ),

              Container(
                  child: ListView(children: [
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
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Shimmer.fromColors(
                                  // Wrap your widget into Shimmer.
                                  baseColor: Colors.grey[100],
                                  highlightColor: Colors.grey[200],
                                  child: Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
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
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 28.0)),
                                                ),
                                                SizedBox(height: 10.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 10.0),
                                                    Text(
                                                      "",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 10.0),
                                                    Text(
                                                      "",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(width: 10.0),
                                                    Text(
                                                      "",
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              50, 50, 93, 1),
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w200),
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
                                                  child: Text(index.toString()),
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
