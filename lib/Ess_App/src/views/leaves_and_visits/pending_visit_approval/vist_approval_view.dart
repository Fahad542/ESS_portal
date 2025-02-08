import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/pending_visit_approval/google_map.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/pending_visit_approval/pending_visit_approval_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import '../../../../My_models/pending_visit_approval.dart';
import '../../../base/utils/constants.dart';
import '../../../services/remote/api_result.dart';
import '../../../services/remote/api_service.dart';
import '../../../shared/loading_indicator.dart';
import '../../../shared/top_app_bar.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/text_theme.dart';
import '../../your_attandence/widget/dropdown.dart';

class Pendingvisitapproval extends StatefulWidget {
  const Pendingvisitapproval({Key? key}) : super(key: key);

  @override
  State<Pendingvisitapproval> createState() => _PendingapprovalState();
}
List<String> dropdownValues = ["Select Status", "approved", "rejected"];
bool shouldShowDropdown = true;
class _PendingapprovalState extends State<Pendingvisitapproval> {
  late GoogleMapController _mapController;
  @override
  // void initState() {
  //   // TODO: implement initState
  //   userviewmodel.fetchuserListApi();
  //   super.initState();
  // }
  Widget build(BuildContext context) {
    return ViewModelBuilder<visitviewmodel>.reactive(
        builder: (viewModelContext, model, child) =>
            Scaffold(
                body: SafeArea(
                    child: Column(
                        children: [
                          GeneralAppBar(
                              title: "Pending Visit Approval",
                              onMenuTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              onNotificationTap: () {}),
                          model.isBusy
                              ? Center(child: LoadingIndicator())
                              : Center(
                              child: SizedBox(
                                  height: context
                                      .screenSize()
                                      .height - 145,
                                  child: ListView.builder(
                                      shrinkWrap: true
                                      ,
                                      itemCount: model.visitapprovaldata.length,
                                      itemBuilder: (context, index) {
                                        model.selectedvisitStatusList;
                                        ApprovalVisitList data = model.visitapprovaldata[index];
                                        void resetSelectedStatus(int index) {
                                          setState(() {
                                            model.selectedvisitStatusList[index] = "Select Status";
                                          });
                                        }

                                        return

                                          Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: BorderRadius
                                                      .circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color:
                                                        AppColors.primary
                                                            .withOpacity(0.6),
                                                        offset: Offset(1, 1),
                                                        blurRadius: 2)
                                                  ]),
                                              margin: EdgeInsets.fromLTRB(
                                                  20, 10, 20, 5),
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 15, 10, 15),
                                              child: Column(

                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,


                                                  children: [

                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(2.0),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: "Employee Name: ",
                                                          style: TextStyling
                                                              .text14
                                                              .copyWith(
                                                              color: AppColors
                                                                  .darkGrey),
                                                          children: [
                                                            TextSpan(
                                                                text: data
                                                                    .name
                                                                    .toString(),
                                                                style: TextStyling
                                                                    .bold14
                                                                    .copyWith(
                                                                  color: AppColors
                                                                      .primary,
                                                                  fontSize: 14,)),
                                                          ],
                                                        ),

                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(2.0),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: "To Date: ",
                                                          style: TextStyling
                                                              .text14
                                                              .copyWith(
                                                              color: AppColors
                                                                  .darkGrey),

                                                          children: [
                                                            TextSpan(
                                                                text: data
                                                                   .date_to
                                                                    .toString(),
                                                                style: TextStyling
                                                                    .text12
                                                                    .copyWith(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 14,)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(2.0),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: "Reason: ",
                                                          style: TextStyling
                                                              .text14
                                                              .copyWith(
                                                              color: AppColors
                                                                  .darkGrey),

                                                          children: [
                                                            TextSpan(
                                                                text: data
                                                                    .reason
                                                                    .toString(),
                                                                style: TextStyling
                                                                    .text12
                                                                    .copyWith(
                                                                  color: AppColors
                                                                      .primary,
                                                                  fontSize: 14,)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(2.0),
                                                      child: RichText(
                                                        text: TextSpan(
                                                          text: "location: ",
                                                          style: TextStyling
                                                              .text14
                                                              .copyWith(
                                                              color: AppColors
                                                                  .darkGrey),

                                                          children: [
                                                            TextSpan(
                                                                text: data
                                                                    .location
                                                                    .toString(),
                                                                style: TextStyling
                                                                    .text12
                                                                    .copyWith(
                                                                  color: AppColors
                                                                      .primary,
                                                                  fontSize: 14,)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .all(2.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                             "Geotag: ",
                                                              style: TextStyling
                                                                  .text14
                                                                  .copyWith(
                                                                  color: AppColors
                                                                      .darkGrey),),
                                                                InkWell(
                                                                    onTap: (){
                                                                      double initialLatitude = double.parse(data.lat);
                                                                      double initialLongitude = double.parse(data.lon);
                                                                      Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(builder: (context) =>
                                                                            geotag(initialLatitude: initialLatitude,
                                                                              initialLongitude: initialLongitude,)), // Replace GeotagScreen with the actual screen widget
                                                                      );
                                                                      // print(initialLatitude);
                                                                      // print(initialLongitude);
                                                                    },
                                                                    child: Icon(Icons.location_on_rounded, color: Colors.red,))


                                                        ],
                                                      ),
                                                      ),


                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Status: ",
                                                          style: TextStyling
                                                              .text14
                                                              .copyWith(
                                                              color: AppColors
                                                                  .darkGrey),
                                                        ),

                                                        buildStatusDropdown(
                                                            model.selectedvisitStatusList[index],
                                                            // Pass the selected status for this item
                                                            dropdownValues,
                                                                (
                                                                String? newValue) async {
                                                              setState(() {
                                                                model.selectedvisitStatusList[index] = newValue; // Update the selected status for this item
                                                              });
                                                              print(model
                                                                  .selectedvisitStatusList[index]);
                                                              print(
                                                                  "Selected value for index $index: $newValue");
                                                              if (newValue ==
                                                                  "Select Status") {
                                                                resetSelectedStatus(
                                                                    index);
                                                              }



                                                              ApiService api = ApiService();
                                                              final response = await api
                                                                  .visitapprovalstatus(
                                                                  newValue!,
                                                                  data.visitid
                                                                      .toString());

                                                              if (response is Success) {
                                                                final jsonResponse = response
                                                                    .data;

                                                                // Check if jsonResponse is not null and contains the "status" property
                                                                if (jsonResponse !=
                                                                    null &&
                                                                    jsonResponse
                                                                        .containsKey(
                                                                        "status")) {
                                                                  final status = jsonResponse["status"];
                                                                  print(
                                                                      "Status: $status");

                                                                  if (newValue ==
                                                                      "approved") {
                                                                    print(
                                                                        newValue);
                                                                    Constants
                                                                        .customSuccessSnack(
                                                                        context,
                                                                        "Request is Approved");
                                                                  } else
                                                                  if (newValue ==
                                                                      "rejected") {
                                                                    Constants
                                                                        .customSuccessSnack(
                                                                        context,
                                                                        "Request is Rejected");
                                                                  }

                                                                  if (newValue ==
                                                                      "approved" || newValue ==
                                                                      "rejected" ||
                                                                      status ==
                                                                          "200") {
                                                                    setState(() {
                                                                      model
                                                                          .visitapprovaldata
                                                                          .removeAt(
                                                                          index);
                                                                      model.selectedvisitStatusList[index] = "Select Status";
                                                                    });
                                                                  }
                                                                } else {
                                                                  // Handle the case where jsonResponse is null or "status" is missing
                                                                  print(
                                                                      "JSON response is null or 'status' is missing");
                                                                }


                                                              }}),


                                                      ],
                                                    ),


                                                  ]));
                                      }
                                  )
                              ))


                        ]))),
        viewModelBuilder: () => visitviewmodel(),
        onModelReady: (model) => model.init(context));
    //onModelReady: (model) => model.init(context),

  }
}

