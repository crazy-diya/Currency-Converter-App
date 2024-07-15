import 'package:currency_converter_app/utils/app_images.dart';
import 'package:currency_converter_app/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/splash/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _bloc = injection.call<SplashCubit>();

  @override
  void initState() {
    _bloc.getSplashData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashSuccessState) {
              Navigator.pushNamed(context, Routes.kExchangerView);
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    AppImages.currencyConvertorImage,
                    height: 20.h,
                    color: AppColors.fontColorWhite,
                  ),
                  Column(
                    children: [
                      Text(
                        AppStrings.welcomeMessage.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.fontColorWhite,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: AppColors.fontColorWhite,
                        size: 22.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
