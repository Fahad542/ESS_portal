import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/shared/bottons.dart';
import 'package:ess/Ess_App/src/views/Loan/customtextfeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../shared/top_app_bar.dart';
import '../../styles/app_colors.dart';
import '../Loan/customsearchabledropdown.dart';
import 'create_sheet_view_model.dart';



class Create_new_sheet extends StatefulWidget {

  @override
  State<Create_new_sheet> createState() => _Create_new_sheetState();

}

class _Create_new_sheetState extends State<Create_new_sheet>
{

  @override
  Widget build(BuildContext context)
  {
    return ViewModelBuilder<CreateSheetViewModel>.reactive(

      builder: (viewModelContext, model, child) =>
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Column(
                children: [
                  GeneralAppBar(
                      title: "Create Sheet",
                      onMenuTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      onNotificationTap: () {}),
                  (model.isBusy == true)
                      ? Center(child: CircularProgressIndicator(
                    color: AppColors.primary,))


                      :  model.warehouse.isEmpty
                      ? Container()
                  :



                  Expanded(
                    child:


                    SizedBox(
                        height: context
                            .screenSize()
                            .height - 145,

                        child:



                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Text('Warehouse', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),textAlign: TextAlign.start,),
                                SizedBox(height: 5,),

                                CustomSearchableDropDown(
                                  items: model.warehouse,
                                  label: model.selectedwarehouse,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(color: const Color(0xff3E4684)),
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(Icons.search),
                                  ),
                                  dropDownMenuItems: model.warehouse.map((e) => e.warehouseName).toList(),

                                  onChanged: (value) {
                                    FocusScope.of(context).unfocus();

                                    {
                                      setState(()
                                      {
                                      model.selectedwarehouse =value!.warehouseId.toString();
                                      print(value);
                                      print(model.selectedwarehouse);
                                      });
                                    }

                                  },

                                ),

                                SizedBox(height: 10,),
                                CustomTextField(controller: model.roomcontroller, labelText: "Room"),
                                SizedBox(height: 10,),
                                CustomTextField(controller: model.thermo_no, labelText: "Thermometer number" ),
                                SizedBox(height: 20,),
                                MainButton( text: "Create New Sheet",
                                    onTap: (){
                                  model.validate(context);
                                } )

                              ],
                            ),
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
      viewModelBuilder: () => CreateSheetViewModel(),
      onModelReady: (model) => model.init(context),

    );
  }

}