import 'package:ess/Ess_App/src/base/utils/utils.dart';
import 'package:ess/Ess_App/src/shared/spacing.dart';
import 'package:ess/Ess_App/src/styles/app_colors.dart';
import 'package:ess/Ess_App/src/styles/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class MainInputField extends StatelessWidget {
  final bool isPassword;
  final String? label;
  final String hint;
  final TextEditingController controller;
  final Function? onTap;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final bool? readOnly;
  final String message;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? width;
  final double? height;

  const MainInputField(
      {Key? key,
      this.width,
      this.height,
      this.isPassword = false,
      this.label,
      required this.hint,
      required this.controller,
      this.onTap,
      this.inputType,
      this.onChanged,
      this.isRequired = true,
      this.suffixIcon,
      this.prefixIcon,
      required this.message,
      this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyling.bold18,
          ),
        VerticalSpacing(),
        Container(
          width: width ?? context.screenSize().width,
          height: height ?? 65,
          decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(bottom: BorderSide(color: AppColors.primary))),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              prefixIcon ?? SizedBox.shrink(),
              Expanded(
                child: TextFormField(
                  onTap: () {
                    onTap!();
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: inputType ?? TextInputType.text,
                  validator: (val) {
                    bool emailValid = true;
                    if (inputType == TextInputType.emailAddress) {
                      emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val!);
                    }
                    return isRequired
                        ? (val!.isEmpty || (emailValid == false))
                            ? message
                            : null
                        : null;
                  },
                  onChanged: (val) {
                    onChanged!(val);
                  },
                  controller: controller,
                  readOnly: (inputType == TextInputType.datetime) ? true : readOnly ?? false,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle:
                        TextStyling.bold18.copyWith(color: AppColors.grey),
                    hintMaxLines: 1,
                    labelStyle: TextStyling.bold18,
                    contentPadding:
                        const EdgeInsetsDirectional.fromSTEB(5, 15, 5, 15),
                  ),
                  cursorColor: AppColors.primary,
                  cursorHeight: 20,
                  style: TextStyling.bold18.copyWith(color: AppColors.primary),
                ),
              ),
              suffixIcon ?? SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

class SecondInputField extends StatelessWidget {
  final bool isPassword;
  final String? label;
  final String hint;
  final TextEditingController controller;
  final Function? onTap;
  final TextInputType? inputType;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final bool? readOnly;
  final String message;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? width;
  final double? height;

  const SecondInputField(
      {Key? key,
      this.width,
      this.height,
      this.isPassword = false,
      this.label,
      required this.hint,
      required this.controller,
      this.onTap,
      this.inputType,
      this.onChanged,
      this.isRequired = true,
      this.suffixIcon,
      this.prefixIcon,
      required this.message,
      this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyling.bold14,
          ),
        VerticalSpacing(),
        Container(
          width: width ?? context.screenSize().width,
          height: height ?? 50,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primary)),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              prefixIcon ?? SizedBox.shrink(),
              Expanded(
                child: TextFormField(
                  onTap: () {
                    onTap!();
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: inputType ?? TextInputType.text,
                  validator: (val) {
                    bool emailValid = true;
                    if (inputType == TextInputType.emailAddress) {
                      emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val!);
                    }
                    return isRequired
                        ? (val!.isEmpty || (emailValid == false))
                            ? message
                            : null
                        : null;
                  },
                  onChanged: (val) {
                    onChanged!(val);
                  },
                  inputFormatters: [
                    if(inputType == TextInputType.phone)
                      MaskedInputFormatter('####-###-####')
                  ],
                  controller: controller,
                  readOnly: (inputType == TextInputType.datetime) ? true : readOnly ?? false,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyling.bold16.copyWith(color: AppColors.grey),
                    hintMaxLines: 1,
                    labelStyle: TextStyling.bold16,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(5, 15, 5, 15),
                  ),
                  cursorColor: AppColors.primary,
                  cursorHeight: 20,
                  style: TextStyling.bold16.copyWith(color: AppColors.primary),
                ),
              ),
              suffixIcon ?? SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomDropDown extends StatelessWidget {
  final String? label;
  final String value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  const CustomDropDown({Key? key, this.label, required this.value, required this.items, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyling.bold16,
          ),
        VerticalSpacing(),
        Container(
          width: context.screenSize().width,
          height: 50,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primary)),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: DropdownButton(
            style: TextStyling.bold16.copyWith(color: AppColors.primary),
            value: value,
            underline: SizedBox.shrink(),
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.transparent,),
            items: items,
            onChanged: (String? newValue) {
              onChanged(newValue);
            },
          ),
        ),
      ],
    );
  }
}

class customDropDown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  customDropDown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,  // Current selected value
      items: items.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,  // The value for each item
          child: Text(item),  // The label text displayed in the dropdown
        );
      }).toList(),  // Convert the list of strings to DropdownMenuItems
      onChanged: onChanged,  // Callback for when the value changes
    );
  }
}