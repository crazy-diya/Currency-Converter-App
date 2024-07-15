import 'dart:convert';

import 'package:currency_converter_app/features/presentation/bloc/exchanger/exchanger_cubit.dart';
import 'package:currency_converter_app/features/presentation/views/exchanger/converted_amount_widget.dart';
import 'package:currency_converter_app/features/presentation/views/exchanger/custom_text_field.dart';
import 'package:currency_converter_app/utils/app_colors.dart';
import 'package:currency_converter_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_constants.dart';
import '../../../data/datasources/shared_preference.dart';

class ExchangerScreen extends StatefulWidget {
  const ExchangerScreen({super.key});

  @override
  State<ExchangerScreen> createState() => _ExchangerScreenState();
}

class _ExchangerScreenState extends State<ExchangerScreen> {
  final _bloc = injection.call<ExchangerCubit>();
  final appSharedData = injection.call<AppSharedData>();
  List<String> favoriteList = [];
  List<String> currencyList = [];

  String selectedType = "";
  double insertAmount = 0.00;
  double selectedKeyValue = 0.00;
  List<double> totalAmount = [];

  @override
  void initState() {
    currencyList.addAll(AppConstants.currencyList!.keys);
    totalAmount.clear();
    if (appSharedData.hasData(savedCurrencies)) {
      List<dynamic> jsonResponse = jsonDecode(appSharedData.getData(savedCurrencies));
      favoriteList = jsonResponse.map((item) => item as String).toList();
      if (favoriteList.isNotEmpty) {
        for (var x in favoriteList) {
          totalAmount.add(0.00);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {},
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.fontColorWhite,
              size: 22.sp,
            ),
          ),
          title: Text(
            AppStrings.advancedExchanger,
            style: TextStyle(
              color: AppColors.fontColorWhite,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => _bloc,
          child: BlocListener<ExchangerCubit, ExchangerState>(
            listener: (context, state) {
              if (state is ExchangerSuccessState) {
                setState(() {
                  AppConstants.currencyList = state.currenciesResponseModel!.data;
                });
                List.generate(favoriteList.length, (index) {
                  AppConstants.currencyList!.forEach((key, value) {
                    if (favoriteList[index] == key) {
                      setState(() {
                        totalAmount[index] = value * insertAmount;
                      });
                    }
                  });
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.insertAmount,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(
                    onChangeAmount: (value) {
                      setState(() {
                        insertAmount = double.parse(value);
                        List.generate(favoriteList.length, (index) {
                          AppConstants.currencyList!.forEach((key, value) {
                            if (favoriteList[index] == key) {
                              setState(() {
                                totalAmount[index] = value * insertAmount;
                              });
                            }
                          });
                        });
                        // totalAmount = (selectedKeyValue * insertAmount);
                      });
                    },
                    onChangeCurrency: (value) {
                      setState(() {
                        selectedType = value;
                      });
                      _bloc.getCurrencyConvertData(type: value);
                    },
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    AppStrings.convertTo,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: favoriteList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ConvertedAmountWidget(
                          onChangeCurrency: (value) {
                            AppConstants.currencyList!.entries.any((element) {
                              if (element.key == value) {
                                setState(() {
                                  favoriteList[index] = value;
                                  selectedKeyValue = element.value;
                                  totalAmount[index] = (selectedKeyValue * insertAmount);
                                });
                                return true;
                              }
                              return false;
                            });
                          },
                          onChangeAmount: (totalAmount[index].toStringAsFixed(2)).toString(),
                          currencyType: favoriteList[index],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          _showCurrencyPicker(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.buttonColorGreen,
                            borderRadius: BorderRadius.circular(
                              10.dp,
                            ),
                          ),
                          padding: EdgeInsets.all(2.5.w),
                          child:  const Text(
                            AppStrings.addConvertor,
                            style: TextStyle(color: AppColors.textColorGreen),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.colorPrimary,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, innerSetState) => Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.favoriteCurrencies,
                        style: TextStyle(
                          color: AppColors.fontColorWhite,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: 100.w - 44,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: List.generate(
                              growable: true,
                              favoriteList.length,
                              (index) => InkWell(
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {
                                  innerSetState(() {
                                    currencyList.add(favoriteList[index]);
                                    setState(() {
                                      favoriteList.removeAt(index);
                                      totalAmount.removeAt(index);
                                    });
                                  });
                                  if (favoriteList.isNotEmpty) {
                                    if (appSharedData.hasData(savedCurrencies)) {
                                      appSharedData.clearData(savedCurrencies);
                                      appSharedData.setData(savedCurrencies, jsonEncode(favoriteList));
                                    } else {
                                      appSharedData.setData(savedCurrencies, jsonEncode(favoriteList));
                                    }
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.colorPrimary,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        favoriteList[index],
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Icon(
                                        Icons.delete_outline,
                                        color: AppColors.removeColorRed,
                                        size: 3.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        AppStrings.addCurrencies,
                        style: TextStyle(
                          color: AppColors.fontColorWhite,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: 100.w - 44,
                        child: Wrap(
                          // gap between adjacent items
                          runSpacing: 4.0,
                          children: List.generate(
                            currencyList.length,
                            (index) {
                              return !favoriteList.contains(currencyList[index])
                                  ? InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      onTap: () {
                                        innerSetState(() {
                                          favoriteList.add(currencyList[index]);
                                          AppConstants.currencyList!.forEach((key, value) {
                                            if (key == currencyList[index]) {
                                              setState(() {
                                                totalAmount.add(insertAmount * value);
                                              });
                                            }
                                          });
                                          currencyList.removeAt(index);
                                        });
                                        if (appSharedData.hasData(savedCurrencies)) {
                                          appSharedData.clearData(savedCurrencies);
                                          appSharedData.setData(savedCurrencies, jsonEncode(favoriteList));
                                        } else {
                                          appSharedData.setData(savedCurrencies, jsonEncode(favoriteList));
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: AppColors.colorPrimary,
                                        ),
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.all(10),
                                        child: Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              currencyList[index],
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Icon(
                                              Icons.add_rounded,
                                              color: AppColors.addColorRed,
                                              size: 3.w,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
