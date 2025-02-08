import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/api_response_models/Capex_model.dart';
import '../../../styles/text_theme.dart';
import '../Capex_view_model.dart';
import 'Capex_detail.dart';
import 'Generate_capex_view_model.dart';
import 'Status_widget.dart';


class GenerateCapex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GenerateCapexViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar
                (

                  title: "Generate Capex",
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  onNotificationTap: () {}

              ),
              if (model.isBusy == true) Center(child: CircularProgressIndicator(color: AppColors.primary,)) else Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child:
   ListView.builder(
      itemCount: model.capexlist.length,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder:

      (BuildContext context, index)


      {
        CapexModel data =model.capexlist[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),

              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                  spreadRadius: 2, // How much the shadow should spread
                  blurRadius: 5, // How blurred the shadow should be
                  offset: Offset(0, 3), // Offset of the shadow (horizontal, vertical)
                ),
              ],
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [

            //    RichText(
            // text: TextSpan(
            // text: " Name: ",
            //   style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
            //   children: [
            //     TextSpan(
            //         text: data.memberName,
            //       style: TextStyle(color: AppColors.primary)
            //        ),
            //   ],
            // ),
            //    ),
              // VerticalSpacing(7),
               RichText(
                 text: TextSpan(
                   text: " Capex id: ",
                   style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
                   children: [
                     TextSpan(
                         text: data.capexId,
                         style: TextStyle(color: AppColors.primary)
                     ),
                   ],
                 ),
               ),

               VerticalSpacing(7),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   RichText(
                     text: TextSpan(
                       text: " Date: ",
                       style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
                       children: [
                         TextSpan(
                             text: data.postedDate,
                             style: TextStyle(color: AppColors.primary)
                         ),
                       ],
                     ),),
                   InkWell(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> capexdetail(itemlist: data.itemList, data: data,)))
                       //model.showCapexDialog(context,data.itemList)
                           ;},
                     child:   Container(

                       decoration: BoxDecoration(

                           gradient: LinearGradient(

                             colors: [AppColors.primary, AppColors.primary], // Replace with your desired colors

                             begin: Alignment.topLeft,

                             end: Alignment.bottomRight,

                           ),

                           boxShadow: [

                             BoxShadow(

                               color: Colors.grey.withOpacity(0.5), // Shadow color with opacity

                               spreadRadius: 2, // How much the shadow should spread

                               blurRadius: 5, // How blurred the shadow should be

                               offset: Offset(0, 3), // Offset of the shadow (horizontal, vertical)

                             ),

                           ],

                           borderRadius: BorderRadius.circular(8)

                       ),

                       child: Padding(

                         padding: const EdgeInsets.all(4),

                         child: Text(



                           'View Details', style: TextStyle(fontSize: 11, color: Colors.white),),

                       ),
                     ),
                   )
                 ],
               ),
               // VerticalSpacing(7),
               // RichText(
               //   text: TextSpan(
               //     text: "Capex Type: ",
               //     style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
               //     children: [
               //       TextSpan(
               //           text: data.capexType,
               //           style: TextStyle(color: AppColors.primary)
               //       ),
               //     ],
               //   ),),
               // VerticalSpacing(7),
               // RichText(
               //   text: TextSpan(
               //     text: "Branch Name: ",
               //     style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
               //     children: [
               //       TextSpan(
               //           text: data.branchName,
               //           style: TextStyle(color: AppColors.primary)
               //       ),
               //     ],
               //   ),),     VerticalSpacing(8),
//                  Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//
//                    statuswidget(title: 'Cord. Status:           ', color:  (data.cordStatus == "pending") ? Colors.blue : (data.cordStatus == "approved") ?  Colors.green : (data.cordStatus == "rejected") ? Colors.red   : Colors.grey, value: data.cordStatus,),
//                        statuswidget(title: 'HOD Status:', color:  (data.hodStatus == "pending") ? Colors.blue : (data.hodStatus == "approved") ?  Colors.green : (data.hodStatus == "rejected") ? Colors.red   : Colors.grey, value: data.hodStatus,),
//
//                        //statuswidget(title: 'HOD Status: ', color: Colors.red, value: data.hodStatus,)
//
// ]),
               VerticalSpacing(7),
//                Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: [
//
//                      statuswidget(title: 'Dept. Head Status: ',  color: Colors.green, value: data.deptHeadStatus,),
//                      statuswidget(title: 'GM Status: ', color: Colors.red, value: data.gmStatus,)
//
//                    ]
//                ),
//                VerticalSpacing(7),
               Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [

                     //statuswidget(title: 'CEO Status:             ',  color: Colors.blue, value: 'Pending',),

                   ])

             ],
            ),
          ),
        );

      }

  ),
)





                  ),
                ),
              
            ],
          ),
        ),
      ),
      viewModelBuilder: () => GenerateCapexViewModel(),
      onModelReady: (model) => model.init(context),
    );}}