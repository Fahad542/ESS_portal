import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class member_details extends StatefulWidget {

  final String desc;
  final String name;
  final String email;
  final String password;
  final String mobile;
  final String imgeAssetPath;
  final String code;
  final String hod;
  member_details({
    required this.desc,
    required this.name,
    required this.email,
    required this.password,
    required this.mobile,
    required this.imgeAssetPath,
    required this.code,
    required this.hod,
  });

  @override
  State<member_details> createState() => _member_detailsState(
    desc: desc,
    name: name,
    email: email,
    password: password,
    mobile: mobile,
    code: code,
    imgeAssetPath: imgeAssetPath,
    hod:hod

  );
}

class _member_detailsState extends State<member_details> {
  final String desc;
  final String name;
  final String email;

  final String password;
  final String mobile;
  final String imgeAssetPath;
  final String code;
  final String hod;

  _member_detailsState({
    required this.desc,
    required this.name,
    required this.email,
    required this.password,
    required this.mobile,
    required this.imgeAssetPath,
    required this.code,
    required this.hod
  });
  Future<void> _makePhoneCall(String phoneNumber) async {
    var status = await Permission.phone.status;
    if (status.isDenied) {
      // Request permission
      await Permission.phone.request();
      status = await Permission.phone.status;
    }

    if (status.isGranted) {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        print('Could not launch $phoneNumber');
      }
    } else {
      print('Phone permission denied');
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // appBar: AppBar(
      //
      //   //iconTheme: IconThemeData(color: AppColors.white),
      //   title: Text("Personal Data", style: TextStyle(color: AppColors.white)),
      // ),
      body: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            AppBarwidget(title: "Personal Data", onMenuTap: (){}, onNotificationTap: (){}),
            SizedBox(height: 16),
            Column(
              children: [
                Center(
                  child: ClipOval(
                    child: Image.network(
                      imgeAssetPath,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: Image.asset(
                            'assets/images/personn.png',

                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Text(code),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 7),
                if(email.isNotEmpty)
                Text(
                  email,
                  style: TextStyle(fontSize: 16),
                ),
                if(email.isNotEmpty)
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Divider(color: AppColors.primary.withOpacity(0.1), thickness: 4.0,),
                ),

              ],
            ),
            SizedBox(height: 34),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.work, color: AppColors.black),
                      SizedBox(width: 8),
                      Text(
                        "Designation:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text("        $desc"
                       ,
                    style: TextStyle(fontSize: 16),
                  ),
                  Divider(color: AppColors.primary.withOpacity(0.1)),
                  Row(
                    children: [
                      Icon(Icons.lock, color: AppColors.black),
                      SizedBox(width: 8),
                      Text(
                        "Password:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "        $password",
                    style: TextStyle(fontSize: 16),
                  ),

                  SizedBox(height: 8),
                  Divider(color: AppColors.primary.withOpacity(0.1)),
                  Row(
                    children: [
                      Icon(Icons.phone, color: AppColors.black),
                      SizedBox(width: 8),
                      Text(
                        "Phone:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),


                    ],

                  ),
                  InkWell(
                    onTap: () async {
                      // const url = 'https://www.google.com';
                      // try {
                      //   if (await canLaunch(url)) {
                      //     await launch(url);
                      //   } else {
                      //     throw 'Could not launch $url';
                      //   }
                      // } catch (e) {
                      //   print(e);
                      // }
                      _makePhoneCall(mobile);
                    },

                    child: Text(
    "         $mobile",
    style: TextStyle(fontSize: 16),
    ),
    ),


                  Divider(color: AppColors.primary.withOpacity(0.1)),
                  Row(
                    children: [
                      Icon(Icons.person, color: AppColors.black),
                      SizedBox(width: 8),
                      Text(
                        "HOD:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),


                    ],

                  ),
                  Text(
                    "         $hod",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

