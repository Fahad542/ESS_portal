import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../360_survey_App/Api_services/data/Local_services/Session.dart';
import '../../360_survey_App/Components/Custom_App_bar.dart';
import '../../Ess_App/src/services/local/navigation_service.dart';
import '../../Ess_App/src/styles/app_colors.dart';
import '../Components/Custom_app_bar.dart';
import '../Components/Drawer.dart';
import '../Components/Lms_home_page_appbar.dart';
import 'main_dashboard/Main_dashboard_view.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  final DrawerController = AdvancedDrawerController();

@override
  void initState() {
  super.initState();
  }

 

  Widget build(BuildContext context) {
    return
      AdvancedDrawer(
        backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primary, Colors.black],
    ),
    ),
    ),
    controller: DrawerController,
    animationCurve: Curves.easeInOut,
    animationDuration: const Duration(milliseconds: 300),
    animateChildDecoration: true,
    rtlOpening: false,
    disabledGestures: false,
    childDecoration: const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    ),

    drawer: CustomSidebar(drawer: DrawerController,),
    child:
    Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            Custom_App_Bar(title: 'Profile',
              onBackPressed: () {
                DrawerController.showDrawer();

            }, onNotificationPressed: () {  },),
            // general_bar(
            //   title: "Profile",
            //   context: context,
            //   adcontroller: DrawerController,
            // ),
            SingleChildScrollView(
              padding:  EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // general_bar(
                  //   title: "Profile",
                  //   context: context,
                  //   adcontroller: DrawerController,
                  // ),
                  const ProfilePic(),
                  const SizedBox(height: 20),
                  ProfileMenu(
                    text: "My Dashboard",
                    icon: "assets/icons/User Icon.svg",
                    press: () => {
                    Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>Main_dashboard()
                    ),

                    )
                    },
                  ),


                  ProfileMenu(
                    text: "Log Out",
                    icon: "assets/icons/Log out.svg",
                    press: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          content: Text(
                            'Are you sure you want to logout?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: AppColors.primary,
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                print("Logging out...");
                                SharedPreferences sp = await SharedPreferences.getInstance();
                                //await sp.clear();
                                sp.remove("lms Login data");
                                lmsUserData.lmsclearUserData();
                                // LmsUserData.clearUserData();
                                Navigator.of(context).pop(); // Close dialog
                                NavService.appmenu(); // Navigate to app menu
                              },
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
      );

  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/images/personn.png",
                  width: 100, // Set the desired width
                  height: 100, // Set the desired height
                  fit: BoxFit.cover, // Ensure the image scales properly
                ),
              ),
              Positioned(
                right: -16,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: const BorderSide(color: Colors.white),
                      ),
                      backgroundColor: const Color(0xFFF5F6F9),
                    ),
                    onPressed: () {},
                    child: SvgPicture.string(cameraIcon),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
        Text(lmsUserData.member_name.toString(), style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Colors.black),),
        SizedBox(height: 5,),
        Text(lmsUserData.mobile.toString(), style: TextStyle(fontSize: 16),)
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFFFF7643),
          padding: const EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [

            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style:  TextStyle(
                  color: AppColors.primary,
                ),
              ),
            ),
             Icon(
              Icons.arrow_forward_ios,
                    color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

const cameraIcon =
'''<svg width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M10 12.0152C8.49151 12.0152 7.26415 10.8137 7.26415 9.33902C7.26415 7.86342 8.49151 6.6619 10 6.6619C11.5085 6.6619 12.7358 7.86342 12.7358 9.33902C12.7358 10.8137 11.5085 12.0152 10 12.0152ZM10 5.55543C7.86698 5.55543 6.13208 7.25251 6.13208 9.33902C6.13208 11.4246 7.86698 13.1217 10 13.1217C12.133 13.1217 13.8679 11.4246 13.8679 9.33902C13.8679 7.25251 12.133 5.55543 10 5.55543ZM18.8679 13.3967C18.8679 14.2226 18.1811 14.8935 17.3368 14.8935H2.66321C1.81887 14.8935 1.13208 14.2226 1.13208 13.3967V5.42346C1.13208 4.59845 1.81887 3.92664 2.66321 3.92664H4.75C5.42453 3.92664 6.03396 3.50952 6.26604 2.88753L6.81321 1.41746C6.88113 1.23198 7.06415 1.10739 7.26604 1.10739H12.734C12.9358 1.10739 13.1189 1.23198 13.1877 1.41839L13.734 2.88845C13.966 3.50952 14.5755 3.92664 15.25 3.92664H17.3368C18.1811 3.92664 18.8679 4.59845 18.8679 5.42346V13.3967ZM17.3368 2.82016H15.25C15.0491 2.82016 14.867 2.69466 14.7972 2.50917L14.2519 1.04003C14.0217 0.418041 13.4113 0 12.734 0H7.26604C6.58868 0 5.9783 0.418041 5.74906 1.0391L5.20283 2.50825C5.13302 2.69466 4.95094 2.82016 4.75 2.82016H2.66321C1.19434 2.82016 0 3.98846 0 5.42346V13.3967C0 14.8326 1.19434 16 2.66321 16H17.3368C18.8057 16 20 14.8326 20 13.3967V5.42346C20 3.98846 18.8057 2.82016 17.3368 2.82016Z" fill="#757575"/>
</svg>
''';
