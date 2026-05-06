import 'package:fit_flex3/core/common/styles/global_text_style.dart';
import 'package:fit_flex3/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomProfileDropdown extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool enabled;

  const CustomProfileDropdown({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: globalTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            dropdownColor: Colors.white,
            value: controller.text.isEmpty ? null : controller.text,
            hint: Text(
              controller.text.isEmpty ? 'null' : hintText,
              style: globalTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textColor1,
              ),
            ),
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, color: AppColors.textColor),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.textColor1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                // border width
                borderSide: const BorderSide(
                  width: 1.3,
                  color: AppColors.textColor1,
                ),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.textColor1),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.textColor1),
              ),
            ),
            items:
            ['male', 'female'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: globalTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor1,
                  ),
                ),
              );
            }).toList(),
            onChanged:
            enabled
                ? (String? newValue) {
              controller.text = newValue ?? '';
            }
                : null,
          ),
        ],
      ),
    );
  }
}