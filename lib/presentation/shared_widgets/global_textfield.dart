import 'package:flutter/material.dart';
import 'package:flutter_svg_icons/flutter_svg_icons.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  //final TextEditingController controller;
  final String hintText;
  final void Function(String) onChanged;

  CustomTextField({
    required this.title,
    //required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFB2BBCA),
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF323E48),
              fontFamily: 'MontserratRegular',
              fontSize: 10,
            ),
          ),
          TextField(
            //controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Color(0xFFB2BBCA)),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextFieldPassword extends StatefulWidget {
  final String title;
  //final TextEditingController controller;
  final String hintText;
  final bool isObscured;
  final void Function(String) onChanged;

  CustomTextFieldPassword({
    required this.title,
    //required this.controller,
    required this.hintText,
    required this.isObscured,
    required this.onChanged,
  });

  @override
  State<CustomTextFieldPassword> createState() =>
      _CustomTextFieldPasswordState();
}

class _CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  @override
  bool _obscureText = true;

  Widget build(BuildContext context) {
    final icon = _obscureText
        ? SvgIconData('assets/icons/eyeOffIcon.svg')
        : SvgIconData('assets/icons/eyeIcon.svg');
    return Container(
      margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFB2BBCA),
          width: 0.2,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Color(0xFF323E48),
              fontFamily: 'MontserratRegular',
              fontSize: 10,
            ),
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                //controller: widget.controller,
                onChanged: widget.onChanged,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: Color(0xFFB2BBCA)),
                  border: InputBorder.none,
                ),
              ),
              IconButton(
                icon: SvgIcon(
                  icon: icon,
                  color: Color(0xFFB2BBCA),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
