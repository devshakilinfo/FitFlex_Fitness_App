import 'package:flutter/material.dart';

class CustomPopupDropdown extends StatelessWidget {
  final List<String> options;
  final String selectedValue;
  final Function(String) onSelected;
  final double height;
  final double textFieldPadding;

  const CustomPopupDropdown({super.key,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
    this.height = 50,
    this.textFieldPadding = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) async {
        final selected = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx,
            0,
          ),
          items: options
              .map((option) => PopupMenuItem<String>(
            value: option,
            child: Text(
              option,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xff5A5C5F),
              ),
            ),
          ))
              .toList(),
          color: Color(0xffF5F6FA), // AppColors.backdownColor
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        );

        if (selected != null) onSelected(selected);
      },
      child: Container(
        height: height,
        padding: EdgeInsets.all(textFieldPadding),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffDFDFDF)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            selectedValue.isEmpty ? "Select Fitness Level" : selectedValue,
            style: TextStyle(
              color: selectedValue.isEmpty
                  ? Color(0xffAAAFB4)
                  : Color(0xff5A5C5F),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
