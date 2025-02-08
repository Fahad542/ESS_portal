import 'package:ess/360_survey_App/Api_services/data/Local_services/Session.dart';
import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../Screens/About_us/About_us_view.dart';
import '../Screens/Lms_Dashboard/Lms_dashboard_view.dart';
import '../Screens/Login/Login_view.dart';
import '../Screens/Profile_screen.dart';
import '../Screens/main_dashboard/Main_dashboard_view.dart';

import 'package:flutter/material.dart';

class CustomSidebar extends StatelessWidget {

   AdvancedDrawerController drawer;
  CustomSidebar({ required this.drawer});
  @override
  Widget build(BuildContext context) {
    return
     SafeArea(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.white,
            iconColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  'assets/images/loho.png',
                ),
                SizedBox(height: 30),
                _buildListTile(Icons.home, 'Home', () {
                    drawer.hideDrawer();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => lms_Dashboard()),

                    );

                }),
                if (lmsUserData.member_id != null)
                  _buildListTile(Icons.dashboard, 'Dashboard', () {
                    drawer.hideDrawer();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Main_dashboard()),

                    );
                  }),

                if (lmsUserData.member_id != null)
                  _buildListTile(Icons.person, 'Profile', () {
                    drawer.hideDrawer();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),

                    );
                  }),
                _buildListTile(Icons.menu, 'All Apps', () {
                  drawer.hideDrawer();
                  NavService.appmenu();
                }),
                if (lmsUserData.member_id == null)
                  _buildListTile(Icons.login, 'Login', () {
                    drawer.hideDrawer();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login_learning_management()),

                    );
                  }),
                Spacer(),
                _buildFooter(),
              ],
            ),
          ),
        ),
      );
  }

  ListTile _buildListTile(IconData icon, String title, VoidCallback onTap, ) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon),
      title: Text(title),
    );
  }

  Widget _buildFooter() {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 12,
        color: Colors.white54,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text('Terms of Service | Privacy Policy'),
      ),
    );
  }
}
