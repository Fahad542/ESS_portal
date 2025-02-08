import 'package:ess/Ess_App/src/services/local/navigation_service.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Learning_management_system/Utilis/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../../generated/assets.dart';
import '../../../styles/text_theme.dart';
import 'attendence_data_table.dart';

class AttendanceScreen extends StatefulWidget {
  List<AttendenceTableData> data;
  AttendanceScreen({required this.data});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int selectedIndex = 0;
  List<String> statuses = [];
  List<AttendenceTableData> filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = widget.data;
    statuses = widget.data.map((e) => e.Attendstatus!).toSet().toList();
    statuses.insert(0, "All");
  }

  // Function to calculate the hour difference between check-in and check-out
  int calculateHourDifference(String checkInTime, String checkOutTime) {
    try {
      DateFormat format = DateFormat("h:mm a");
      DateTime timeIn = format.parse(checkInTime);
      DateTime timeOut = format.parse(checkOutTime);
      Duration difference = timeOut.difference(timeIn);
      return difference.inHours;
    } catch (e) {
      print("Error parsing time: $e");
      return 0;
    }
  }


  void filterDataByStatus(String status) {
    setState(() {
      if (status == "All") {
        filteredData = widget.data;
      } else {
        filteredData = widget.data
            .where((item) => item.Attendstatus == status)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary),
            ),
            child: ListView.builder(

                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: statuses.length,
                itemBuilder: (context, index) {
                  var data = statuses[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        filterDataByStatus(data);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100, // Set a fixed width for each item
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: selectedIndex == index ? AppColors.primary : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          data,
                          style: TextStyle(
                            color: selectedIndex == index ? AppColors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          SizedBox(height: 15),
          if (filteredData.isNotEmpty)
            Expanded(
              child:

              ListView.builder(

                physics: BouncingScrollPhysics(),
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  var datalist = filteredData[index];

                  // Calculate hours difference for each data entry
                  String checkIn = (datalist.checkIn is List) ? datalist.checkIn[0] : datalist.checkIn;
                  String checkOut = (datalist.checkOut is List) ? datalist.checkOut[0] : datalist.checkOut;
                  int hoursDifference = calculateHourDifference(checkIn, checkOut);
                  if(hoursDifference <0 )
                    {
                      hoursDifference =0;
                    }

                  return
                    Slidable(
                      enabled: (datalist.statusColor == Colors.orange),
                  key: ValueKey(datalist.date.toString()),
                  endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      flex: 2,
                      onPressed: (_) {
                       NavService.applyLeave();
                      },
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      label: 'Apply Leave',
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),


                  ],
                  ),
                  child:


                    Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.withOpacity(0.1),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.black.withOpacity(0.2), // Light shadow color
                      //     spreadRadius: 1, // Small spread
                      //     blurRadius: 3,   // Blur effect to soften the shadow
                      //     offset: Offset(0, 5), // Shadow position (x, y)
                      //   ),
                      // ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height:  datalist.Attendstatus != "Absent"  ? 62 : 74,
                            margin: EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        datalist.date,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                           "Work hours: ",
                                            style: TextStyle(
                                           fontSize: 11,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          Text(
                                            hoursDifference.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(

                                    children: [
                                      Icon(Icons.arrow_downward, size: 14, color: AppColors.primary,),
                                      Text("${datalist.checkIn }", style: TextStyle(color: Colors.grey, fontSize: 12),),
                                      HorizontalSpacing(7),
                                      Icon(Icons.arrow_upward, size: 14 , color: AppColors.primary),
                                      Text("${datalist.checkOut}", style: TextStyle(color: Colors.grey, fontSize: 12),),
                                      Spacer(),
                                      if(datalist.Attendstatus == "Absent")

                                        Lottie.asset(Assets.imagesSwapLottie, height:28, width: 30,)
,                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                              color: datalist.statusColor,
                                              borderRadius: BorderRadius.circular(
                                               4
                                              ),
                                            ),
                                            child: Text(
                                              datalist.Attendstatus.toString(),
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400 ,fontSize: 10),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
                },
              ),
            ),
          if (filteredData.isEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Data Not Available",
                style: TextStyling.bold18.copyWith(color: AppColors.darkGrey),
              ),
            ),
        ],
      ),
    );
  }
}
