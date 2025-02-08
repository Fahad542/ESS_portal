import 'package:ess/Ess_App/src/shared/bottons.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/shared/top_app_bar.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../base/utils/constants.dart';
import '../../shared/input_field.dart';
import 'Capex_view_model.dart';

class ApplyCapexform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CapexViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar
                (

                  title: "Apply Capex",
                  onMenuTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  onNotificationTap: () {}

                ),
              (model.isBusy == true)
                  ? Center(child: CircularProgressIndicator(color: AppColors.primary,))
                  : Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(18, 20, 18, 0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft, // Aligns content to the start of the container
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Employee Name: ',
                                  style: TextStyle(
                                    color: Colors.black, // Adjust color and other styling as needed
                                  ),
                                ),
                                TextSpan(
                                  text: model.currentUser!.userName.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary // Adjust color and other styling as needed
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalSpacing(10),
                        Container(
                          alignment: Alignment.centerLeft, // Aligns content to the start of the container
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Employee Code: ',
                                  style: TextStyle(
                                    color: Colors.black, // Adjust color and other styling as needed
                                  ),
                                ),
                                TextSpan(
                                  text: model.currentUser!.userId.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary // Adjust color and other styling as needed
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalSpacing(10),
                        Container(
                          alignment: Alignment.centerLeft, // Aligns content to the start of the container
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Email: ',
                                  style: TextStyle(
                                    color: Colors.black, // Adjust color and other styling as needed
                                  ),
                                ),
                                TextSpan(
                                  text: model.currentUser!.email.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary // Adjust color and other styling as needed
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalSpacing(10),
                        Container(
                          alignment: Alignment.centerLeft, // Aligns content to the start of the container
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Designation: ',
                                  style: TextStyle(
                                    color: Colors.black, // Adjust color and other styling as needed
                                  ),
                                ),
                                TextSpan(
                                  text: model.currentUser!.member_designation.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary // Adjust color and other styling as needed
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        CustomDropDown(

                          value: model.capexForList.isNotEmpty
                              ? model.capexForList[model.capexForIndex]
                              : '', // Default value if the list is empty
                          items: model.capexForList.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (String? newValue) async
                          {
                            model.selectedItemIndices.clear();
                            model.newIndex = 0;
                            if (newValue != null)
                            {
                              model.selectedItemIndices.clear();
                              model.newIndex = 0;
                              // Update the selected Capex and index
                              model.selectedcapexForList = newValue; // Save the selected Capex
                              model.capexForIndex = model.capexForList.indexWhere((element) => element == newValue);
                              print(model.selectedcapexForList);
                              // Clear and update other lists
                              model.selectedCapex.clear();
                              model.quantities.clear();
                              model.addDropdownItem(); // Adjust this as needed
                              await model.getItems(context);
                              // Notify listeners to update the UI
                              model.notifyListeners();
                            }
                          },
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(""),
                            InkWell(
                              onTap: ()
                              {
                                if (model.selectedcapexForList.isEmpty) {
                                  Constants.customErrorSnack(context, "Please Select the Capex Type First");
                                } else {
                                  model.addDropdownItem();
                                  print(model.newIndex);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Add +", style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        ListView.builder(
                          itemCount: model.selectedItemIndices.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            model.indexcapex=index+1;
                            final itemIndex = model.selectedItemIndices[index];
                            final selectedItem = model.items[itemIndex];
                            final currentValue = model.selectedCapex.length > index ? model.selectedCapex[index] : '';
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select Capex: ", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey, // Set the border color
                                        width: 1.0, // Set the border width
                                      ),
                                      borderRadius: BorderRadius.circular(5.0), // Set the border radius
                                    ),
                                    child: DropdownButton<String>(
                                      value: currentValue.isNotEmpty ? currentValue : null,
                                      isDense: true,
                                      isExpanded: true,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Select Capex"),
                                          value: "",
                                        ),
                                        ...model.items.where((element) => element.Category == model.selectedcapexForList).map<DropdownMenuItem<String>>((e) {
                                          return DropdownMenuItem(
                                            child: Text(e.itemName!),
                                            value: e.id,
                                          );
                                        }).toList(),
                                      ],
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {

                                          if (model.selectedCapex.length > index) {
                                            model.selectedCapex[index] = newValue;
                                            model.quantities[index]=1;
                                          } else {
                                            // If the list is shorter than the current index, extend it
                                            while (model.selectedCapex.length <= index) {
                                              model.selectedCapex.add('');
                                            }
                                            model.selectedCapex[index] = newValue;
                                            model.quantities[index]=1;
                                            print(model.selectedCapex[index]);
                                          }
                                          print(newValue);
                                          model.notifyListeners();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Quantity: "),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            if (index < model.selectedCapex.length && model.selectedCapex[index].isNotEmpty) {
                                              model.decrementQuantity(index);
                                            } else {
                                              Constants.customErrorSnack(context, "Please Select the Capex Item First");
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Icon(Icons.remove, color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Text("${model.quantities[index]}"),
                                        SizedBox(width: 5,),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            if (index < model.selectedCapex.length && model.selectedCapex[index].isNotEmpty) {
                                              model.incrementQuantity(index);
                                            } else {
                                              Constants.customErrorSnack(context, "Please Select the Capex Item First");
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child: Icon(Icons.add, color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (index > 0)
                                      InkWell(
                                        onTap: () {
                                          model.removeDropdownItem(index);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Remove", style: TextStyle(color: Colors.white)),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                              ],
                            );
                          },
                        ),
                        MainButton(
                          text: "Apply Capex",
                          isBusy: model.isBusy,
                          onTap: ( ) {
                            print( "indexcapex: ${model.indexcapex}");
                            print("index: ${model.newIndex}");
                            List<String> length=[];
                            List<String> nonZeroCapex = model.selectedCapex.where((item) => item != '').toList();
                                 print(model.selectedCapex);
                            print("Selected Capex non-zero count: ${nonZeroCapex.length}");
                            if(model.indexcapex == nonZeroCapex.length)
                              {
                                model.applycapex(context);
                              }
                            else
                              {
                               Constants.customErrorSnack(context, "Please ensure all Capex items are selected.");
                              }
                          },
                        ),

                      ],
                    )


                  ),
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => CapexViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
