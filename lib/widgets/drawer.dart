import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../Screens/login_screen.dart';
import 'dart:async';
import '../services/auth_services/auth_service.dart';

import '../constants/Theme.dart';

import 'drawer-tile.dart';

class ArgonDrawer extends StatelessWidget {
  final String currentPage;

  ArgonDrawer({this.currentPage});

  _launchURL() async {
    const url = 'https://creative-tim.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: ArgonColors.white,
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.85,
                child: SafeArea(
                  bottom: false,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Image.asset("assets/images/argon-logo.png"),
                    ),
                  ),
                )),
            Expanded(
              flex: 2,
              child: ListView(
                padding: EdgeInsets.only(top: 24, left: 16, right: 16),
                children: [
                  DrawerTile(
                      icon: Icons.home,
                      onTap: () {
                        if (currentPage != "Home")
                          Navigator.pushReplacementNamed(context, '/home');
                      },
                      iconColor: ArgonColors.primary,
                      title: "Home",
                      isSelected: currentPage == "Home" ? true : false),
                  DrawerTile(
                      icon: Icons.pie_chart,
                      onTap: () {
                        if (currentPage != "Edit Profile")
                          Navigator.pushReplacementNamed(
                              context, '/edit_profile');
                      },
                      iconColor: ArgonColors.warning,
                      title: "Edit Profile",
                      isSelected: currentPage == "Edit Profile" ? true : false),
                  DrawerTile(
                      icon: Icons.meeting_room,
                      onTap: () {
                        if (currentPage != "Appointments")
                          Navigator.pushReplacementNamed(
                              context, '/appointments');
                      },
                      iconColor: ArgonColors.info,
                      title: "Appointments",
                      isSelected: currentPage == "Appointments" ? true : false),
                  DrawerTile(
                      icon: Icons.local_hospital,
                      onTap: () {
                        if (currentPage != "Medications")
                          Navigator.pushReplacementNamed(
                              context, '/Medications');
                      },
                      iconColor: ArgonColors.info,
                      title: "Medications",
                      isSelected: currentPage == "Medications" ? true : false),
                  DrawerTile(
                      icon: Icons.note,
                      onTap: () {
                        if (currentPage != "Prescriptions")
                          Navigator.pushReplacementNamed(
                              context, '/prescriptions');
                      },
                      iconColor: ArgonColors.error,
                      title: "Prescriptions",
                      isSelected:
                          currentPage == "Prescriptions" ? true : false),
                  DrawerTile(
                      icon: Icons.paste,
                      onTap: () {},
                      iconColor: ArgonColors.primary,
                      title: "Pathology Reports",
                      isSelected: currentPage == "Articles" ? true : false),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(left: 8, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(height: 4, thickness: 0, color: ArgonColors.muted),
                    DrawerTile(
                        icon: Icons.logout,
                        onTap: () {
                          context.read<AuthenticationService>().signOut();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        iconColor: ArgonColors.muted,
                        title: "Log Out",
                        isSelected: currentPage == "Log Out" ? true : false),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
