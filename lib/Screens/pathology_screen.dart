import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/Theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../services/data_services/notifiers/appointment_data.dart';
import 'package:quiver/iterables.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/navbar.dart';
import '../widgets/drawer.dart';
import 'package:photo_view/photo_view.dart';

class Pathology extends StatefulWidget {
  const Pathology({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  PathologyState createState() => PathologyState(index);
}

class PathologyState extends State<Pathology> {
  int index;
  var k;
  var tests;
  PathologyState(this.index);
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LoadAppointmentData>(context).loadAppointments();
    var list = Provider.of<LoadAppointmentData>(context)
        .appointments[
            Provider.of<LoadAppointmentData>(context).appointments.length -
                1 -
                index]
        .values
        .elementAt(0)[0]['Reports'];
    tests = Provider.of<LoadAppointmentData>(context)
        .appointments[
            Provider.of<LoadAppointmentData>(context).appointments.length -
                1 -
                index]
        .values
        .elementAt(0)[0]['Tests'];
    List l1 = [];
    List l2 = [];
    if(list!=null){
          for (var i = 0; i < list.length; i++) {
      l1.add(list[i]['report']);
      l2.add(list[i]['url']);
    }

    }


    k = zip([l1, l2]);
    print(index);
    if (list !=
        null) {
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
            SingleChildScrollView(
              child: Container(
                  child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Align(
                          child: Text(
                              Provider.of<LoadAppointmentData>(context)
                                  .appointments[
                                      Provider.of<LoadAppointmentData>(context)
                                              .appointments
                                              .length -
                                          1 -
                                          index]
                                  .values
                                  .elementAt(0)[0]['hospital']
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 20.0)),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Align(
                                child: Text(
                                    "Dr. " +
                                        Provider.of<LoadAppointmentData>(
                                                context)
                                            .appointments[
                                                Provider.of<LoadAppointmentData>(
                                                            context)
                                                        .appointments
                                                        .length -
                                                    1 -
                                                    index]
                                            .values
                                            .elementAt(0)[0]['doctor'],
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: 16.0)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    Provider.of<LoadAppointmentData>(context)
                                        .appointments[
                                            Provider.of<LoadAppointmentData>(
                                                        context)
                                                    .appointments
                                                    .length -
                                                1 -
                                                index]
                                        .keys
                                        .elementAt(0),
                                    style: TextStyle(
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: 16.0)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.98,
                    color: Colors.blue,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Reports ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(50, 50, 93, 1),
                                  fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                    ),
                    child: Table(
                      border: TableBorder.all(
                          width: 1,
                          color: Colors.blue,
                          style: BorderStyle.solid),
                      children: [
                        TableRow(children: [
                          Text(
                            'Report',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Scan',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20,
                    ),
                    child: createTable(),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                ],
              )),
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: Navbar(
          title: "Prescriptions",
          transparent: true,
        ),
        backgroundColor: ArgonColors.primary,
        drawer: ArgonDrawer(currentPage: "Prescriptions"),
        body: Center(
          // heightFactor: 3,
          // widthFactor: 0.8,
          child: Container(
            child: Text(
              'No Reports Found',
              textScaleFactor: 3,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }

  Widget createTable() {
    List<TableRow> rows = [];
    for (var i in k) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: Text(i[0]),
        ),
        InkWell(
          child: Image.network(i[1]),
          onTap: () {
            return Container(
                child: PhotoView(
              imageProvider: NetworkImage(i[1]),
            ));
          },
        ),
      ]));
    }
    return Table(
      children: rows,
      border: TableBorder.all(
          width: 1, color: Colors.blue, style: BorderStyle.solid),
    );
  }
}
