import 'package:ess/Ess_App/src/base/utils/constants.dart';
import 'package:ess/Ess_App/src/models/api_response_models/capex_forms.dart';
import 'package:ess/Ess_App/src/services/local/base/auth_view_model.dart';
import 'package:ess/Ess_App/src/services/remote/base/api_view_model.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CapexDetailViewModel extends ReactiveViewModel with AuthViewModel, ApiViewModel {
  final Datalist data;

  CapexDetailViewModel(this.data);

  List<TableRow> itemTableData = [];
  int subtotal = 0;
  int total = 0;
  init(){
    subtotal = 0;
    total = 0;
    itemTableData.clear();
    itemTableData.add(
        TableRow(
        decoration: BoxDecoration(
          color: AppColors.primary,
        ),
        children: [
          Text("Item",style: TextStyling.bold18.copyWith(color: AppColors.white, fontSize: 14,),textAlign: TextAlign.center,),
          Text("Specs",style: TextStyling.bold18.copyWith(color: AppColors.white, fontSize: 14,),textAlign: TextAlign.center,),
          Text("Qty x Price",style: TextStyling.bold18.copyWith(color: AppColors.white, fontSize: 14,),textAlign: TextAlign.center,),
          Text("Quotation",style: TextStyling.bold18.copyWith(color: AppColors.white, fontSize: 14,),textAlign: TextAlign.center,),
        ]
      )
    );
    data.itemdetail?.forEach((element) {
      int _total = (double.parse(element.qty.toString()) * double.parse(element.price.toString())).round();
      subtotal += _total;
      total = subtotal;
      itemTableData.add(
          TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(element.item.toString() ?? "" ,style: TextStyling.text18.copyWith(color: AppColors.primary, fontSize: 14,),textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(element.specs.toString() ?? "" ,style: TextStyling.text18.copyWith(color: AppColors.primary, fontSize: 14,),textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text("${element.qty.toString()}x${element.price.toString()}\n=${_total.toString()}",style: TextStyling.text18.copyWith(color: AppColors.primary, fontSize: 14,),textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text("Download" ,style: TextStyling.text18.copyWith(color: AppColors.primary, fontSize: 14,),textAlign: TextAlign.center,),
                ),
              ]
          )
      );
    });
  }
  Color colorSelection(String title) {
    switch (title.toLowerCase()) {
      case "approved":
        {
          return Colors.green;
        }
      case "pending":
        {
          return Colors.orange;
        }
      case "rejected":
        {
          return Colors.red;
        }
      default:
        {
          return AppColors.primary;
        }
    }
  }
}
