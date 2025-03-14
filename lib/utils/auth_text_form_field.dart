import 'package:assignment/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart' as validator;

class CustomTextField extends StatelessWidget {
  final TextEditingController controllerIs;
  final TextInputType keyboardApperanceType;
  final String? hintTextIs;
  final IconData? suffixIconIs;
  final IconData? prefixIconIs;
  final FocusNode focusNode;
  final bool? obscureTextIs;
  final FocusNode? nextFocusNode;
  final validator.FormFieldValidator<String>? fieldValidator;
  final VoidCallback? onSuffixIconTap; // callback when suffix icon tapped

  const CustomTextField({
    super.key,
    required this.controllerIs,
    required this.keyboardApperanceType,
    this.hintTextIs,
    this.suffixIconIs,
    this.obscureTextIs,
    this.prefixIconIs,
    required this.focusNode,
    this.nextFocusNode,
    this.fieldValidator,
    this.onSuffixIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(obscureTextIs), // forces rebuild when obscureTextIs changes
      controller: controllerIs,
      keyboardType: keyboardApperanceType,
      validator: fieldValidator,
      focusNode: focusNode,
      textInputAction:
      nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
      onFieldSubmitted: (_) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintTextIs ?? "",
        hintStyle: const TextStyle(color: Colors.grey, fontFamily: "Poppins"),
        filled: true,
        fillColor: AppColors.lightColor,
        suffixIcon: suffixIconIs != null
            ? InkWell(
          onTap: onSuffixIconTap,
          child: Icon(
            suffixIconIs,
            color: Colors.grey,
          ),
        )
            : null,
        prefixIcon: prefixIconIs != null
            ? Icon(
          prefixIconIs,
          color: Colors.grey,
        )
            : null,
        enabledBorder: _buildBorder(AppColors.lightColor),
        focusedBorder: _buildBorder(AppColors.lightColor),
        errorBorder: _buildBorder(AppColors.lightColor),
        focusedErrorBorder: _buildBorder(AppColors.lightColor),
        errorStyle: const TextStyle(height: 0),
      ),
      obscureText: obscureTextIs ?? false,
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: color),
    );
  }
}
