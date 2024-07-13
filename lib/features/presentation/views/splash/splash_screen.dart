import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/dependency_injection.dart';
import '../../bloc/splash/splash_cubit.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _bloc = injection.call<SplashCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashSuccessState) {
              print("done its working Now!");
            }
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Welcome"),
                TextButton(
                  onPressed: () async {
                    await _bloc.getSplashData();
                  },
                  child: const Text("Click Me"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
