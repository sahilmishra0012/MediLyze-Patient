import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/Theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

//widgets
import 'package:MedilyzePatient/widgets/navbar.dart';
import 'package:MedilyzePatient/widgets/drawer.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  List data = ['ABC', 'PQR', 'XYZ', 'OPN', 'QNIFD'];
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "Profile",
        transparent: true,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Profile"),
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
          Container(
            child: ListView(children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 74.0),
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: .0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 85.0, bottom: 20.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Align(
                                          child: Text("Sahil Mishra",
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
                                            Icon(MdiIcons.genderMale,
                                                color: ArgonColors.initial,
                                                size: 22.0),
                                            SizedBox(width: 10.0),
                                            Text("22",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        50, 50, 93, 1),
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(MdiIcons.phone,
                                                color: ArgonColors.initial,
                                                size: 22.0),
                                            SizedBox(width: 10.0),
                                            Text("7007059528",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        50, 50, 93, 1),
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(MdiIcons.emailBox,
                                                color: ArgonColors.initial,
                                                size: 22.0),
                                            SizedBox(width: 10.0),
                                            Text("sahilmishra32@gmail.com",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        50, 50, 93, 1),
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.w200)),
                                          ],
                                        ),
                                        Divider(
                                          height: 40.0,
                                          thickness: 1.5,
                                          indent: 32.0,
                                          endIndent: 32.0,
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
                              backgroundImage: AssetImage(
                                  "assets/images/T2IOXmFYANXDE1f8PfpD6ArgI0m1.jpg"),
                              radius: 65.0,
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
                                try{return Container(
                                  alignment: Alignment.center,
                                  child: Card(
                                    child: GestureDetector(
                                      child: Container(
                                        child: Text(data[index]),
                                        height: 220,
                                        width: double.maxFinite,
                                      ),
                                      onTap: () {
                                        print(index);
                                      },
                                    ),
                                    elevation: 5,
                                  ),
                                );}
                                catch(e){
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
