import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../models/api_response_models/warehouse_list_model.dart';
import '../../shared/top_app_bar.dart';
import '../../styles/app_colors.dart';
import '../Loan/customsearchabledropdown.dart';
import '../your_attandence/widget/dropdown.dart';
import 'View_sheets_view_model.dart';
class view_sheet extends StatefulWidget {
  Warehouselist? data;
  view_sheet({ this.data});
  @override
  State<view_sheet> createState() => _Create_new_sheetState();
}

class _Create_new_sheetState extends State<view_sheet> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SheetViewModel>.reactive(
      builder: (viewModelContext, model, child) =>
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    GeneralAppBar(
                        title: "Store Incharge Approval",
                        onMenuTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        onNotificationTap: () {}),



                    ( model.isBusy == true )
                        ? Center( child: CircularProgressIndicator (
                      color: AppColors.primary,) )
                        :
                    SizedBox(
                      height: context.screenSize().height - 145,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true, // To allow the list to take up available space
                                itemCount: model.datalist.length,
                                itemBuilder: (BuildContext context, index) {
                                  var data = model.datalist[index];

                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Card(
                                      elevation: 5,
                                     // margin: EdgeInsets.symmetric(vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(16),

                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          Align(
                                          alignment: Alignment.topCenter,  // You can also use Alignment.topLeft or Alignment.topRight
                                          child:
                                          Container(
                                            width: 300,
                                              padding:EdgeInsets.all(12),
                                              decoration:BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.2), // Shadow color with some transparency
                                                      spreadRadius: 2, // How much the shadow will spread
                                                      blurRadius: 4,  // How blurred the shadow will be
                                                      offset: Offset(0, 4), // Shadow position (x, y)
                                                    ),
                                                  ],
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: AppColors.primary

                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: "Thermometer Number: ",
                                                          style: TextStyle(color: Colors.white, fontSize: 15),
                                                        ),
                                                        TextSpan(
                                                          text: "${data.thermometerNo}",
                                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 2,),
                                                  Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: "Warehouse: ",

                                                          style: TextStyle(color: Colors.white , fontSize: 15),
                                                        ),
                                                        TextSpan(
                                                          text: "${data.warehouse}",
                                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 2,),
                                                  Text.rich(
                                                    TextSpan(
                                                      children:
                                                      [
                                                        TextSpan(
                                                          text: "Month Year: ",
                                                          style: TextStyle(color: Colors.white , fontSize: 15),),
                                                        TextSpan(
                                                          text: "${data.monthYear}",
                                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 15),),
                                                      ],
                                                    ),
                                                  ),
                                                ]
                                              ),
                                            ),
                                          ),

                                        SizedBox(height: 30,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [

                                                    // Add some space between the icon and text
                                                    Text(
                                                      "Temperature Reading",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.black,
                                                      ),
                                                    ),
                                                    SizedBox(width: 2),
                                                    Icon(
                                                      Icons.thermostat,  // Thermometer icon
                                                      size: 20,           // Size of the icon
                                                      color: Colors.red, // Icon color
                                                    ),
                                                  ],
                                                ),

                                                InkWell(
                                                  onTap: ()
                                                  {
                                                    model.showimage(context, data.attach1);
                                                  },child:
                                                Container(

                                                  padding:EdgeInsets.all(6),
                                                  decoration:BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black.withOpacity(0.2), // Shadow color with some transparency
                                                          spreadRadius: 2, // How much the shadow will spread
                                                          blurRadius: 4,  // How blurred the shadow will be
                                                          offset: Offset(0, 4), // Shadow position (x, y)
                                                        ),
                                                      ],
                                                      borderRadius: BorderRadius.circular(8),
                                                      color: AppColors.primary
                                                  ),

                                                  child: Text("View image", style: TextStyle(color: Colors.white, fontSize: 13),),
                                                ),)
                                              ],
                                            ),
                                            Text("Current Temperature: ${data.curTemp}", style: TextStyle(color: Colors.black)),
                                            Text("Maximum Temperature: ${data.maxTemp}", style: TextStyle(color: Colors.black)),
                                            Text("Minimum Temperature: ${data.minTemp}", style: TextStyle(color: Colors.black)),

                                            SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [

                                                   // Space between icon and text
                                                    Text(
                                                      "Humidity Reading",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppColors.black,
                                                      ),

                                                    ),
                                                    SizedBox(width: 2),
                                                    Icon(
                                                      Icons.water_drop,  // Water drop icon for humidity
                                                      size: 20,           // Size of the icon
                                                      color: Colors.blue,  // Icon color
                                                    ),
                                                  ],
                                                )
,
                                                InkWell(
                                                  onTap: ()
                                                  {
                                                      model.showimage(context, data.attach2);
                                                  },
                                                  child: Container(

                                                    padding:EdgeInsets.all(6),
                                                    decoration:BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black.withOpacity(0.2), // Shadow color with some transparency
                                                            spreadRadius: 2, // How much the shadow will spread
                                                            blurRadius: 4,  // How blurred the shadow will be
                                                            offset: Offset(0, 4), // Shadow position (x, y)
                                                          ),
                                                        ],
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: AppColors.primary

                                                    ),

                                                    child: Text("View image", style: TextStyle(color: Colors.white, fontSize: 13),),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text("Current Humidity: ${data.currHumidity}", style: TextStyle(color: Colors.black)),
                                            Text("Maximum Humidity: ${data.maxHumidity}", style: TextStyle(color: Colors.black)),
                                            Text("Minimum Humidity: ${data.minHumidity}", style: TextStyle(color: Colors.black)),
SizedBox(height: 10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [


                                                buildStatusDropdown(
                                                    model.selectedOption[index],

                                                    model.list,
                                                        (
                                                        String? value) async {
                                                      setState(()  {
                                                        model.selectedOption[index] = value!;

                                                        if(value != "Select Status") {

                                                          if (value == 'Approved') {
                                                            model.selectedOption[index] = "approved";
                                                          }
                                                          if (value == "Rejected") {
                                                            model.selectedOption[index] = "rejected";
                                                          }
                                                          model.approval(context, index, data.id, model.selectedOption[index]);

                                                          model.selectedOption[index] = "Select Status";
                                                          print(model.selectedOption[index]);
                                                        }

                                                        //
                                                        //



                                                      }); })

    ]
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
                    )
                  ],
                ),
              ),
            ),
          ),
      viewModelBuilder: () => SheetViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}






