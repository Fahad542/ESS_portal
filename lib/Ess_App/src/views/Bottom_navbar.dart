import 'package:ess/Ess_App/src/models/api_response_models/dashboard.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/views/your_attandence/widget/Attendance_widget.dart';
import 'package:ess/Ess_App/src/views/your_attandence/your_attandence_view.dart';
import 'package:ess/Learning_management_system/Screens/Profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/api_response_models/attendence.dart';
import '../styles/app_colors.dart';
import 'dashboard/dashboard_view.dart';

class MyBottomNavBar extends StatefulWidget {
  MyBottomNavBar();

  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _selectedIndex = 0;

  // List of pages to display based on the selected index
  final List<Widget> _pages = [
  YourAttendanceView(),
  DashboardView(),
  ProfileScreen()

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: AppColors.primary,
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        backgroundColor: AppColors.primary,
      ),
    );
  }
}


