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

class Prescription extends StatefulWidget {
  const Prescription({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  PrescriptionState createState() => PrescriptionState(index);
}

class PrescriptionState extends State<Prescription> {
  int index;
  var k;
  var tests;
  PrescriptionState(this.index);
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
        .elementAt(0)[0]['Medicines'];
    tests = Provider.of<LoadAppointmentData>(context)
        .appointments[
            Provider.of<LoadAppointmentData>(context).appointments.length -
                1 -
                index]
        .values
        .elementAt(0)[0]['Tests'];
    List l1 = [];
    List l2 = [];
    List l3 = [];
    for (var i = 0; i < list.length; i++) {
      l1.add(list[i]
          .split(" ")
          .sublist(0, list[i].split(" ").length - 2)
          .join(" "));
      l2.add(list[i].split(" ")[list[i].split(" ").length - 2]);
      l3.add(list[i].split(" ")[list[i].split(" ").length - 1]);
    }

    k = zip([l1, l2, l3]);

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
          Container(
              child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: Align(
                            child: Text(
                                "Dr. " +
                                    Provider.of<LoadAppointmentData>(context)
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
                              right: MediaQuery.of(context).size.width * 0.05),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Complaints: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(50, 50, 93, 1),
                              fontSize: 18.0),
                        ),
                        TextSpan(
                          text: Provider.of<LoadAppointmentData>(context)
                              .appointments[
                                  Provider.of<LoadAppointmentData>(context)
                                          .appointments
                                          .length -
                                      1 -
                                      index]
                              .values
                              .elementAt(0)[0]['complaints'],
                          style: TextStyle(
                              color: Color.fromRGBO(50, 50, 93, 1),
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Diagnosis: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(50, 50, 93, 1),
                              fontSize: 18.0),
                        ),
                        TextSpan(
                          text: Provider.of<LoadAppointmentData>(context)
                              .appointments[
                                  Provider.of<LoadAppointmentData>(context)
                                          .appointments
                                          .length -
                                      1 -
                                      index]
                              .values
                              .elementAt(0)[0]['diagnosis'],
                          style: TextStyle(
                              color: Color.fromRGBO(50, 50, 93, 1),
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image(
                    image: AssetImage("assets/images/rx.png"),
                    height: MediaQuery.of(context).size.height * 0.02,
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
                  children: [
                    TableRow(children: [
                      Text(
                        'Medicine',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Dosage',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Timing-Duration',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Tests ",
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                ),
                child: createList(),
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
                          text: "Next Visit: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(50, 50, 93, 1),
                              fontSize: 18.0),
                        ),
                        TextSpan(
                          text: Provider.of<LoadAppointmentData>(context)
                              .appointments[
                                  Provider.of<LoadAppointmentData>(context)
                                          .appointments
                                          .length -
                                      1 -
                                      index]
                              .values
                              .elementAt(0)[0]['next_visit'],
                          style: TextStyle(
                              color: Color.fromRGBO(50, 50, 93, 1),
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget createTable() {
    List<TableRow> rows = [];
    for (var i in k) {
      rows.add(TableRow(children: [
        Text(i[0]),
        Text(i[1]),
        Text(i[2]),
      ]));
    }
    return Table(children: rows);
  }

  Widget createList() {
    List<TableRow> rows = [];
    int j = 1;
    for (var i in tests) {
      rows.add(TableRow(children: [
        InkWell(
          child: Text(
            j.toString() +
                ". " +i,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(50, 50, 93, 1),
                fontSize: 18.0),
          ),
          onTap: () => launch(i.split(" ")[i.split(" ").length - 1]),
        ),
      ]));
      j++;
    }
    return Table(children: rows);
  }
}
