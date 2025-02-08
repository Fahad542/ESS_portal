
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class Course_detail_view extends StatefulWidget {
  var data;
  List attachments;
  Course_detail_view({required this.data,  required this.attachments});

  @override
  State<Course_detail_view> createState() => _Course_detail_viewState();
}

class _Course_detail_viewState extends State<Course_detail_view> {

  @override
  void initState() {
print("attachment :${widget.attachments.toString()}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(  // Wrap the entire body inside SingleChildScrollView
          child: Padding(
            padding: EdgeInsets.all(8.0),  // Optional padding for better readability
            child: Column(
              children: [
                Html(
                  data: widget.data,  // Assuming 'data' holds the HTML content
                ),

                ListView.builder(
                  shrinkWrap: true,
                    itemCount: widget.attachments.length,
                    itemBuilder: (BuildContext context, index)
                    {
                      var data=widget.attachments[index]['fileName'];
                      var datas=widget.attachments[index]['attachmentUrl'];
                      return Column(children: [
                        Row(children:
                        [
                          Expanded(
                              flex:3,
                              child: Text("Attachment", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black , fontSize: 16),)),
                          Expanded(
                            flex:7,
                            child: Text(
                              "Url",
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 16),
                              // Limit to a single line, you can adjust this
                            ),
                          ),


                        ],),
                       SizedBox(height: 12,),
                       // Divider(color: AppColors.primary,),
                        Row(children:
                        [
                          Expanded(
                              flex:3,
                              child: Text("${data}:", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),)),
                          Expanded(
                              flex:7,
                              child: InkWell(
                                onTap:() async {


                                    await launch(datas);  // Open the URL in the default browser


                                },
                                child: Text(
                                    "${datas}",
                                    style: TextStyle(color: AppColors.black),
                                     // Limit to a single line, you can adjust this
                                  ),
                              ),
                            ),

                          Divider(color: AppColors.primary,)

                        ],),
                        Divider(color: AppColors.primary,)
                     //   Text("${data}: ${datas}")
                      ],);
                      
                      
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
