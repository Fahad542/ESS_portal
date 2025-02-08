import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Ess_App/src/styles/app_colors.dart';
class CusTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? inputType;
  final List<TextInputFormatter>? formatter;
  final bool editable; // Editable property
  final Widget? prefixIcon; // Prefix icon property
  final bool obscureText; // Secure text field option

  const CusTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.inputType,
    this.editable = true,
    this.formatter,
    this.prefixIcon,
    this.obscureText = false, // Default is false
  }) : super(key: key);

  @override
  _CusTextFieldState createState() => _CusTextFieldState();
}

class _CusTextFieldState extends State<CusTextField> {
  final FocusNode _focusNode = FocusNode();
  late bool _obscureText; // State for visibility

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
    _obscureText = widget.obscureText;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        // boxShadow: _focusNode.hasFocus
        //     ? [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.4), // Shadow color
        //     spreadRadius: 2, // Spread radius
        //     blurRadius: 5, // Blur radius
        //     offset: Offset(0, 3), // Offset of the shadow
        //   ),
        // ]
             // No shadow when not focused
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        inputFormatters: widget.formatter,
        enabled: widget.editable,
        focusNode: _focusNode, // Attach the FocusNode
        obscureText: _obscureText, // Use the current state of obscureText

        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          border: InputBorder.none,
          prefixIcon: widget.prefixIcon, // Use the prefix icon here
          suffixIcon:
          widget.obscureText==true ?
          IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: AppColors.primary,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText; // Toggle the obscureText state
              });
            },
          ) : null
        ),
      ),
    );
  }
}
