import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../styles/app_colors.dart';
import 'Member_details.dart';
class Attendieswidget extends StatelessWidget {
  final int index;
  final String imgeAssetPath;
  final String email;
  final String password;
  final String mobile;
  final String desc;
  final String name;
  final String tablenumber;
  final String code;
  final String hod;


  Attendieswidget({
    required this.code,
    required this.index,
    required this.imgeAssetPath,
    required this.email,
    required this.password,
    required this.mobile,
    required this.desc,
    required this.name,
    required this.tablenumber,
    required this.hod
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => member_details(
              desc: desc,
              name: name,
              email: email,
              password: password,
              mobile: mobile,
              imgeAssetPath: imgeAssetPath,
              code: code,
              hod:hod
            ),
          ),
        );
      },
      child: Container(
        height: 90,
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            ClipOval(
              child: Image.network(
                imgeAssetPath,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Image.asset(
                      'assets/images/personn.png',

                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(
                      color: AppColors.yellow,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    code,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward,color: AppColors.white,)
          ],
        ),
      ),
    );
  }
}


  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.primary),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
