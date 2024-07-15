import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_constants.dart';

class ConvertedAmountWidget extends StatefulWidget {
  final String onChangeAmount;
  final Function(String value) onChangeCurrency;
  final String currencyType;

  const ConvertedAmountWidget({
    super.key,
    required this.onChangeCurrency,
    required this.onChangeAmount,
    required this.currencyType,
  });

  @override
  State<ConvertedAmountWidget> createState() => _ConvertedAmountWidgetState();
}

class _ConvertedAmountWidgetState extends State<ConvertedAmountWidget> {
  late String _selectedCurrency;

  @override
  void initState() {
    setState(() {
      _selectedCurrency = widget.currencyType;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorSecondary,
        borderRadius: BorderRadius.circular(4.w),
      ),
      padding: const EdgeInsets.only(
        right: 10,
        left: 15,
        top: 10,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.onChangeAmount,
            style: TextStyle(
              color: AppColors.fontColorWhite,
              fontSize: 18.sp,
            ),
          ),
          DropdownButtonHideUnderline(
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
        ],
      ),
    );
  }
}
