import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/api_response_models/Capex_model.dart';
import '../../../shared/spacing.dart';
import '../../../shared/top_app_bar.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/text_theme.dart';
import 'Status_widget.dart';

class capexdetail extends StatefulWidget {
  final CapexModel data;
  final List<Items> itemlist;

  capexdetail({required this.data, required this.itemlist});

  @override
  State<capexdetail> createState() => _CapexDetailState();
}
double total=0;
class _CapexDetailState extends State<capexdetail> {
  @override
  void initState() {
    super.initState();
    // Calculate the total cost
    setState(() {
      total = widget.itemlist.fold(0.0, (sum, item) => sum + item.total);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: double.infinity, // To ensure the container takes full width
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarwidget(title: "Capex Details", onMenuTap: (){}, onNotificationTap: (){}),

                RichText(
                  text: TextSpan(
                    text: "Name: ",
                    style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
                    children: [
                      TextSpan(
                          text: widget.data.memberName,
                          style: TextStyle(color: AppColors.primary)
                      ),
                    ],
                  ),),
                VerticalSpacing(8),
                RichText(
                  text: TextSpan(
                    text: "Employee code: ",
                    style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
                    children: [
                      TextSpan(
                          text: widget.data.empCode,
                          style: TextStyle(color: AppColors.primary)
                      ),
                    ],
                  ),),
                VerticalSpacing(8),
                RichText(
                  text: TextSpan(
                    text: "Branch Name: ",
                    style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
                    children: [
                      TextSpan(
                          text: widget.data.branchName,
                          style: TextStyle(color: AppColors.primary)
                      ),
                    ],
                  ),),
                VerticalSpacing(8),
                RichText(
                  text: TextSpan(
                    text: "Capex Type: ",
                    style: TextStyling.bold18.copyWith(color: AppColors.black, fontSize: 12,),
                    children: [
                      TextSpan(
                          text: widget.data.capexType,
                          style: TextStyle(color: AppColors.primary)
                      ),
                    ],
                  ),
                ),
                VerticalSpacing(10),
                                 Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [

                       statuswidget(title: 'Cord. Status:           ', color:  (widget.data.cordStatus == "pending") ? Colors.blue : (widget.data.cordStatus == "approved") ?  Colors.green : (widget.data.cordStatus == "rejected") ? Colors.red   : Colors.grey, value: widget.data.cordStatus,),
                       statuswidget(title: 'HOD Status: ', color:  (widget.data.hodStatus == "pending") ? Colors.blue : (widget.data.hodStatus == "approved") ?  Colors.green : (widget.data.hodStatus == "rejected") ? Colors.red   : Colors.grey, value: widget.data.hodStatus,),

                       //statuswidget(title: 'HOD Status: ', color: Colors.red, value: data.hodStatus,)

]),
                VerticalSpacing(7),
               Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [

                     statuswidget(title: 'Dept. Head Status: ',  color:  (widget.data.deptHeadStatus == "pending") ? Colors.blue : (widget.data.deptHeadStatus == "approved") ?  Colors.green : (widget.data.deptHeadStatus == "rejected") ? Colors.red   : Colors.grey, value: widget.data.deptHeadStatus,),
                     statuswidget(title: 'GM Status: ', color:  (widget.data.gmStatus == "pending") ? Colors.blue : (widget.data.gmStatus == "approved") ?  Colors.green : (widget.data.gmStatus == "rejected") ? Colors.red   : Colors.grey, value: widget.data.gmStatus,)

                   ]
               ),
                VerticalSpacing(7),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      statuswidget(title: 'CEO Status:             ',  color:  (widget.data.ceoStatus == "pending") ? Colors.blue : (widget.data.ceoStatus == "approved") ?  Colors.green : (widget.data.ceoStatus == "rejected") ? Colors.red   : Colors.grey, value: widget.data.ceoStatus,),

                    ]
                ),
                VerticalSpacing(14),

                VerticalSpacing(14),
            Column(
              children: [
                Row(children: [
                  Expanded(
                      flex:2,
                      child: Text("No.", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),)),
                  Expanded(
                      flex:5,
                      child: Text("Item Name", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),)),
                  Expanded(
                      flex:2,
                      child: Text("Qtn", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold))),
                  Expanded(
                      flex:2,
                      child:Text("Total", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold))),
                  Expanded(
                      flex:2,
                      child:Text("Price", style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold))),

                ],),
                Divider(color: AppColors.primary, )
              ],
            ),
                ListView.builder(
                  shrinkWrap: true,
                    itemCount: widget.data.itemList.length,
                    itemBuilder: (BuildContext context, index)

                {
                  final dataitem = widget.data.itemList[index];
                  return Column(
                    children: [
                      Row(children: [
                        Expanded(
                            flex:2,
                            child: Text("${index+1}")),
                        Expanded(
                            flex:5,
                            child: Text(dataitem.itemName)),
                        Expanded(
                            flex:2,
                            child: Text(dataitem.qty)),
                Expanded(
                flex:2,
                child:Text(dataitem.total.toString())),
                        Expanded(
                            flex:2,
                            child:Text(dataitem.price.toString())),

                      ],),
                      Divider(color: AppColors.primary, )
                    ],
                  );
                }


                ),
                // Table(
                //   border: TableBorder.all(),
                //   columnWidths: {
                //     0: FlexColumnWidth(2), // Adjust column widths as needed
                //     1: FlexColumnWidth(1),
                //     2: FlexColumnWidth(1),
                //     3: FlexColumnWidth(1),
                //   },
                //   children: [
                //
                //     // TableRow(
                //     //   decoration: BoxDecoration(
                //     //     color: Colors.grey[300], // Background color for the header row
                //     //   ),
                //     //   children: [
                //     //     TableCell(
                //     //       child: Padding(
                //     //         padding: const EdgeInsets.all(8.0),
                //     //         child: Text(
                //     //           'Item Name',
                //     //           style: TextStyle(fontWeight: FontWeight.bold),
                //     //         ),
                //     //       ),
                //     //     ),
                //     //     TableCell(
                //     //       child: Padding(
                //     //         padding: const EdgeInsets.all(8.0),
                //     //         child: Text(
                //     //           'Quantity',
                //     //           style: TextStyle(fontWeight: FontWeight.bold),
                //     //         ),
                //     //       ),
                //     //     ),
                //     //     TableCell(
                //     //       child: Padding(
                //     //         padding: const EdgeInsets.all(8.0),
                //     //         child: Text(
                //     //           'Rate',
                //     //           style: TextStyle(fontWeight: FontWeight.bold),
                //     //         ),
                //     //       ),
                //     //     ),
                //     //     TableCell(
                //     //       child: Padding(
                //     //         padding: const EdgeInsets.all(8.0),
                //     //         child: Text(
                //     //           'Total',
                //     //           style: TextStyle(fontWeight: FontWeight.bold),
                //     //         ),
                //     //       ),
                //     //     ),
                //     //   ],
                //     // ),
                //     // Table rows from itemlist
                //     ...widget.itemlist.map((item) {
                //       return TableRow(
                //         children: [
                //            Text(item.itemName),
                //
                //
                //           TableCell(
                //             child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text(item.qty.toString()),
                //             ),
                //           ),
                //           TableCell(
                //             child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text("${item.price.toString()} RS"),
                //             ),
                //           ),
                //           TableCell(
                //             child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Text("${item.total.toString()} RS"),
                //             ),
                //           ),
                //         ],
                //       );
                //     }).toList(),
                //   ],
                // ),
                //erticalSpacing(10),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,

                    children: [
                  Text(""),
                      Container(
                        decoration: BoxDecoration(color: AppColors.primary,
                        borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              text: "Total: ",
                              style: TextStyling.bold18.copyWith(
                                color: AppColors.white,
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  text: "${total.toString()} RS",
                                  style: TextStyle(
                                    color: AppColors.white,

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )



                    ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}