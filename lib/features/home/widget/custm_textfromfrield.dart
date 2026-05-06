import 'package:fit_flex3/core/common/styles/global_text_style.dart' show globalTextStyle;
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String titleText;
  final String hintText;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.0),
        Text(
          titleText,
          style: globalTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xff5A5C5F),
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          height: 40,
          child: TextFormField(
            autofocus: true,
            onChanged: onChanged,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 5),
              hintText: hintText,
              hintStyle: TextStyle(
                color: const Color(0xffAAAFB4),
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: const Color(0xffDFDFDF)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: const Color(0xffDFDFDF)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: const Color(0xffDFDFDF)),
              ),
            ),
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
