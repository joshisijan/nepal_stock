import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/palette.dart';

class CustomTextField extends StatelessWidget {
  
  final EdgeInsets padding, margin;
  final String hint, helperText, label, outerTitle, errorText;
  final TextStyle hintStyle, helperStyle, labelStyle, outerTitleStyle, errorStyle;
  final bool password, onlyNumber;
  final TextEditingController controller;
  final Function onEditingComplete, validator, onChanged;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FocusNode focusNode;

  const CustomTextField({
    Key key, 
    this.padding,
    this.margin,
    this.hint,
    this.hintStyle,
    this.helperText,
    this.onChanged,
    this.helperStyle,
    this.label,
    this.labelStyle,
    this.outerTitle,
    this.outerTitleStyle,
    this.errorText,
    this.errorStyle,
    this.password,
    this.controller,
    this.onEditingComplete,
    this.textInputAction,
    this.keyboardType,
    this.onlyNumber = false,
    this.focusNode,
    this.validator
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding ?? EdgeInsets.zero,
      margin: this.margin ?? EdgeInsets.zero,
      child: Column(
        children: [
          this.outerTitle != null ? Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              this.outerTitle ?? '',
              style: this.outerTitleStyle ?? Theme.of(context).textTheme.caption,
              textAlign: TextAlign.left,
            ),
          ) : SizedBox.shrink(),
          TextFormField(
            focusNode: this.focusNode,
            decoration: InputDecoration(
              hintText: this.hint ?? '',
              hintStyle: this.hintStyle ?? TextStyle(),
              helperText: this.helperText ?? '',
              helperStyle: this.helperStyle ?? TextStyle(),
              labelText: this.label ?? '',
              labelStyle: this.labelStyle ?? TextStyle(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0,),
              errorText: this.errorText ?? null,
              errorStyle: this.errorStyle ?? TextStyle(
                color: Palette.lightGreen,
              ),
              border: OutlineInputBorder(),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Palette.darkGreen,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Palette.darkGreen,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Palette.darkGreen,
                ),
              ),
            ),
            cursorColor: Palette.lightGreen,
            obscureText: this.password ?? false,
            controller: this.controller ?? null,
            textInputAction: this.textInputAction ?? TextInputAction.done,
            onEditingComplete: this.onEditingComplete ?? (){

            },
            onChanged: this.onChanged ?? (value){

            },
            inputFormatters: this.onlyNumber ?  [
              WhitelistingTextInputFormatter.digitsOnly,
            ] : [],
            keyboardType: this.keyboardType ?? TextInputType.text,
            validator: this.validator ?? (value){
              return null;
            },
          ),
        ],
      ),
    );
  }
}
