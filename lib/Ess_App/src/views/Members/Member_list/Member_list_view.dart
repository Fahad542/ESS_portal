import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../models/api_response_models/Member_model.dart';
import '../../../shared/loading_indicator.dart';
import '../../../shared/top_app_bar.dart';
import '../Searchable_textfeild.dart';
import '../Widgets.dart';
import 'Member_list_view_model.dart';


class MemberList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MemberViewModel>.reactive(
      builder: (viewModelContext, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              GeneralAppBar(
                title: "All Members",
                onMenuTap: () {
                  Scaffold.of(context).openDrawer();
                },
                onNotificationTap: () {},
              ),
              model.isBusy
                  ? Center(child: LoadingIndicator())
                  : Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextFields(
                        controller: model.controller,
                        onChanged: (query) {
                          model.updatesearchquery(query);
                        },

                      ),
                      SizedBox(height: 20,),
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.filteredData.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            Member data = model.filteredData[index];
                            return Attendieswidget(
                              code:data.memberCode,
                              desc: data.memberDesignation.toString(),
                              name: data.memberName,
                              tablenumber: '',
                              index: index + 1,
                              imgeAssetPath: data.dp.toString(),
                              email: data.memberEmail.toString(),
                              password: data.memberPassword.toString(),
                              mobile: data.mobile.toString(),
                              hod:data.hod.toString()
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => MemberViewModel(),
      onModelReady: (model) => model.init(context),
    );
  }
}
