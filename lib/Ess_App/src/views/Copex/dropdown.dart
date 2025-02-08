import 'package:flutter/material.dart';

class DropDownHelper extends StatefulWidget {
  List dropDownListData=[];
   DropDownHelper({Key? key, required this.dropDownListData
  }) : super(key: key);

  @override
  State<DropDownHelper> createState() => _DropDownHelperState();
}

class _DropDownHelperState extends State<DropDownHelper> {
  List dropDownListData = [
    {"title": "BCA", "value": "1"},
    {"title": "MCA", "value": "2"},
    {"title": "B.Tech", "value": "3"},
    {"title": "M.Tech", "value": "4"},
  ];

  String selectedCourseValue = "";
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            DropdownButton<String>(
              value: selectedCourseValue,
              isDense: true,
              isExpanded: true,
              menuMaxHeight: 350,
              items: [
                const DropdownMenuItem(
                    child: Text(
                      "Select Course",
                    ),
                    value: ""),
                ...dropDownListData.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                      child: Text(e['title']), value: e['value']);
                }).toList(),
              ],
              onChanged: (newValue) {
                setState(
                      () {
                    selectedCourseValue = newValue!;
                    print(selectedCourseValue);
                  },
                );
              },
            ),


          ],
        ));
  }
}
