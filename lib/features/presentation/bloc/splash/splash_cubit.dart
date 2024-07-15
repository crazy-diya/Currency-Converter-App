import 'package:bloc/bloc.dart';
import 'package:currency_converter_app/utils/app_constants.dart';
import 'package:meta/meta.dart';

import '../../../../error/failures.dart';
import '../../../domain/usecases/splash_usecase.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final Splash splash;

  SplashCubit({required this.splash}) : super(SplashInitial());

  Future<dynamic> getSplashData({String? type = "USD"}) async {
    emit(ApiLoadingState());
    final result = await splash({"apikey": AppConstants.apiKey, "base_currency": type});
    emit(
      result.fold(
        (l) {
          if (l is DioExceptionFailure) {
            return DioExceptionFailureState();
          } else if (l is ServerFailure) {
            return ServerFailureState();
          } else if (l is ConnectionFailure) {
            return ConnectionFailureState();
          } else {
            return ApiFailureState();
          }
        },
        (r) {
          AppConstants.currencyList = r.data;
          return SplashSuccessState();
        },
      ),
    );
  }
}
