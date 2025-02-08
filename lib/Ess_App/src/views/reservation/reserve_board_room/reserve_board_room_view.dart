import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/shared/bottons.dart';
import 'package:ess/Ess_App/src/shared/input_field.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/views/reservation/reserve_board_room/reserve_board_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

class ReserveBoardRoomView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      ViewModelBuilder<ReserveBoardRoomViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                  title: "Reserve Board Room",
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
                                onTap: () {

                                },
                                message: 'Please enter employee code',
                              ),
                              VerticalSpacing(20),
                              CustomDropDown(
                                value: model.boardRoams[model.boardRoamSelectedIndex],
                                items: model.boardRoams.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  model.boardRoamSelectedIndex = model.boardRoams.indexWhere((element) => element == newValue);
                                  model.notifyListeners();
                                },
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Booking Date',
                                hint: 'Select Booking Date',
                                controller: model.bookDate,
                                inputType: TextInputType.datetime,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100));


                                  if (pickedDate != null) {
                                    model.bookDateFormat = pickedDate;
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    model.bookDate.text = formattedDate;
                                    model.notifyListeners();
                                  } else {

                                  }
                                },
                                message: 'Please select booking date',
                                prefixIcon: Icon(
                                  Icons.calendar_month,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              VerticalSpacing(20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SecondInputField(
                                    label: 'Start Time',
                                    hint: 'Select Start Time',
                                    controller: model.fromTime,
                                    inputType: TextInputType.datetime,
                                    onTap: () async {
                                      TimeOfDay? pickedTime = await showTimePicker(
                                          context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      if (pickedTime != null) {
                                        if(pickedTime.minute == 0){
                                          model.fromTimeFormat = pickedTime;
                                          model.fromTime.text = "${pickedTime.hour}";
                                        }else {
                                          model.fromTimeFormat = pickedTime;
                                          model.fromTime.text = "${pickedTime.hour}:${pickedTime.minute}";
                                        }
                                        model.notifyListeners();
                                      }
                                    },
                                    width: context.screenSize().width / 2.4,
                                    message: 'Please select start time',
                                    prefixIcon: Icon(
                                      Icons.access_time,
                                      color: AppColors.primary,
                                      size: 24,
                                    ),
                                  ),
                                  SecondInputField(
                                    label: 'End Time',
                                    hint: 'Select End Time',
                                    controller: model.toTime,
                                    inputType: TextInputType.datetime,
                                    onTap: () async {
                                      TimeOfDay? pickedTime = await showTimePicker(
                                        context: context,
                                        initialTime: model.fromTimeFormat,
                                      );
                                      if (pickedTime != null) {
                                        if(pickedTime.minute == 0){
                                          model.toTime.text = "${pickedTime.hour}";
                                        }else {
                                          model.toTime.text = "${pickedTime.hour}:${pickedTime.minute}";
                                        }
                                        model.notifyListeners();
                                      }
                                    },
                                    width: context.screenSize().width / 2.4,
                                    message: 'Please select end time',
                                    prefixIcon: Icon(
                                      Icons.access_time,
                                      color: AppColors.primary,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'No of People',
                                hint: 'Enter No of People',
                                controller: model.nop,
                                inputType: TextInputType.number,
                                onTap: (){},
                                message: 'Please enter no of people',
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Agenda',
                                hint: 'Enter Agenda',
                                controller: model.agenda,
                                inputType: TextInputType.multiline,
                                onTap: (){},
                                message: 'Please enter agenda',
                              ),
                              VerticalSpacing(20),
                              SecondInputField(
                                label: 'Reason',
                                hint: 'Enter Reason',
                                controller: model.remarks,
                                inputType: TextInputType.multiline,
                                onTap: (){},
                                message: 'Please enter reason',
                              ),
                              VerticalSpacing(20),
                              MainButton(
                                  text: "Reserve",
                                  isBusy: model.isBusy,
                                  onTap: () {
                                    model.apply(ctx);
                                  }
                                  ),
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
      viewModelBuilder: () => ReserveBoardRoomViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
