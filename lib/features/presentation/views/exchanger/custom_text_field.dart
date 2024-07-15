import 'package:currency_converter_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final Function(String value) onChangeAmount;
  final Function(String value) onChangeCurrency;

  const CustomTextField({super.key, required this.onChangeAmount, required this.onChangeCurrency});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  String _selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorSecondary,
        borderRadius: BorderRadius.circular(4.w),
      ),
      padding: const EdgeInsets.only(right: 10),
      child: TextFormField(
        controller: _controller,
        enabled: true,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        style: TextStyle(color: AppColors.fontColorWhite, fontSize: 18.sp),
        onChanged: (value) {
          if (value.isNotEmpty) {
            widget.onChangeAmount(value);
          } else {
            widget.onChangeAmount("0.00");
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(18),
          hintText: '0.00',
          hintStyle: TextStyle(color: AppColors.fontColorWhite, fontSize: 18.sp),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          suffixIcon: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCurrency,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20.sp,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCurrency = newValue!;
                });
                widget.onChangeCurrency(newValue!);
              },
              items: AppConstants.currencyList!.keys.map<DropdownMenuItem<String>>((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
