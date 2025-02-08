import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/shared/bottons.dart';
import 'package:ess/Ess_App/src/shared/input_field.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/views/leaves_and_visits/apply_visit/apply_visit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class ApplyVisitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplyVisitViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                  title: "Apply Visit",
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  onNotificationTap: () {}),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      child: Builder(
                        builder: (ctx) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SecondInputField(
                                label: 'Employee Code',
                                hint: 'Enter Employee Code',
                                controller: model.employeeCode,
                                inputType: TextInputType.text,
                                readOnly: true,
                                onTap: () {},
                                message: 'Please enter employee code',
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'From Date',
                                hint: 'Select From Date',
                                controller: model.fromDate,
                                inputType: TextInputType.datetime,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    model.toDateFormat = pickedDate;
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd').format(pickedDate);
                                    model.fromDate.text = formattedDate;
                                    model.notifyListeners();
                                  } else {}
                                },
                                message: 'Please select from Date',
                                prefixIcon: Icon(
                                  Icons.calendar_month,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'To Date',
                                hint: 'Select To Date',
                                controller: model.toDate,
                                inputType: TextInputType.datetime,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: model.toDateFormat,
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd').format(pickedDate);
                                    model.toDate.text = formattedDate;
                                    model.notifyListeners();
                                  } else {}
                                },
                                message: 'Please select to date',
                                prefixIcon: Icon(
                                  Icons.calendar_month,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Location',
                                hint: 'Enter Location',
                                controller: model.visitLocation,
                                inputType: TextInputType.multiline,
                                onTap: () {},
                                message: 'Please enter location',
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Reason',
                                hint: 'Enter Reason',
                                controller: model.visitReason,
                                inputType: TextInputType.multiline,
                                onTap: () {},
                                message: 'Please enter reason',
                              ),
                              VerticalSpacing(20),
                              SizedBox(
                                height: 200,
                                width: context.screenSize().width,
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: model.location,
                                  markers: Set<Marker>.of(model.markers.values),
                                  onMapCreated: (GoogleMapController controller) {
                                    model.controller.complete(controller);
                                  },
                                ),
                              ),
                              VerticalSpacing(20),
                              MainButton(
                                  text: "Apply",
                                  isBusy: model.isBusy,
                                  onTap: () {
                                    model.apply(ctx);
                                  }),
                              VerticalSpacing(20),
                            ],
                          );
                        }
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ApplyVisitViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
