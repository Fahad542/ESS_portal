import 'package:ess/Ess_App/src/views/QMS/tempurature-list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../shared/top_app_bar.dart';
import '../../styles/app_colors.dart';
import 'add_temperature.dart';

class tempurature_list_view extends StatefulWidget {
  @override
  State<tempurature_list_view> createState() => _Create_new_sheetState();
}

class _Create_new_sheetState extends State<tempurature_list_view> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<temperaure_listViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.all(8.0),
            child: Column(
              children: [
                GeneralAppBar(
                  title: "Add Temperature",
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  onNotificationTap: () {},
                ),
                // Show a loading indicator when the model is busy
                if (model.isBusy)
                  Center(child: CircularProgressIndicator(color: AppColors.primary)),
                // Otherwise, show the list
                if (!model.isBusy)
                  Expanded(  // Use Expanded to allow ListView to take up the remaining space
                    child: ListView.builder(
                      itemCount: model.warehouse.length,
                      itemBuilder: (BuildContext context, index) {
                        var data = model.warehouse[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child:
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[

                                  Text(
                                      data.warehouseName,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),

                                        SizedBox(height: 6),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Room Lane: ",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: "${data.roomLane}",
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold , fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Month year: ",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: "${data.monthYear}",
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Thermometer No: ",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            TextSpan(
                                              text: "${data.thermometerNo}",
                                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),


                                      Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => TemperatureHumidityForm(data: data)));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: AppColors.primary,
                                              onPrimary: Colors.white,
                                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Text("Record Temperature"),
                                          ),

                                          SizedBox(width: 5),
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     Navigator.push(context, MaterialPageRoute(builder: (context) => view_sheet(data: data)));
                                          //
                                          //   },
                                          //   style: ElevatedButton.styleFrom(
                                          //     primary: AppColors.primary,
                                          //     onPrimary: Colors.white,
                                          //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                          //     shape: RoundedRectangleBorder(
                                          //       borderRadius: BorderRadius.circular(10),
                                          //     ),
                                          //   ),
                                          //   child: Text("View Temp Sheet"),
                                          // ),
                                        ],
                                      ),
                                  ),

                              ],
                            ),
                                ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => temperaure_listViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
