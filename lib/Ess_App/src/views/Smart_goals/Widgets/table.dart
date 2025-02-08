import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../styles/text_theme.dart';

class Mysmartgoaldata {
  final String Goal_Name;
  final String Goal_Detail;
  final String Measures;
  final String Weightage;
  final String Your_Score;
  final String Manager_Score;

  Mysmartgoaldata({
    required this.Goal_Name,
    required this.Goal_Detail,
    required this.Measures,
    required this.Weightage,
    required this.Your_Score,
    required this.Manager_Score


  });
}
class table extends StatelessWidget {
  final Mysmartgoaldata heading;
  final List<Mysmartgoaldata> data;
  const table({ Key? key, required this.heading , required this.data})  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: AppColors.primary, width: 2),
borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                      Expanded(
                          flex: 3,
                          child: Text(heading.Goal_Name, style: TextStyle(color: AppColors.white),)),

                    Expanded(
                        flex: 3,
                        child: Text(heading.Goal_Detail, style: TextStyle(color: AppColors.white))),
                    Expanded(
                        flex: 2,
                        child: Text(heading.Measures, style: TextStyle(color: AppColors.white))),
                    Expanded(
                        flex: 2,
                        child: Text(heading.Weightage, style: TextStyle(color: AppColors.white))),
                  ],

                ),
              ),
            ),

            (data.length >0) ?
            Container( child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text(data[index].Goal_Name,style: TextStyle(fontWeight: FontWeight.bold),)),

                        Expanded(
                            flex: 4,
                            child: Text(data[index].Goal_Detail)),
                        Expanded(
                            flex: 2,
                            child: Text(data[index].Measures, style:TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                            flex: 1,
                            child: Text('${data[index].Weightage}%', style:TextStyle(fontWeight: FontWeight.bold,color: Colors.red))),
                      ],
                    ),




                  ],),
                );

              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Divider(
                    color: AppColors.grey,
                    thickness: 0.4,
                  ),
                );
              },
            )):Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Data Not Available",
                style: TextStyling.bold18
                    .copyWith(color: AppColors.darkGrey),
              ),
            ),


          ],

        ),
      ),
    );
  }
}
