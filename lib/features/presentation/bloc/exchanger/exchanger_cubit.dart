import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../error/failures.dart';
import '../../../../utils/app_constants.dart';
import '../../../data/model/currencies_response_model.dart';
import '../../../domain/usecases/splash_usecase.dart';

part 'exchanger_state.dart';

class ExchangerCubit extends Cubit<ExchangerState> {
  final Splash splash;

  ExchangerCubit({required this.splash}) : super(ExchangerInitial());

  Future<dynamic> getCurrencyConvertData({String? type = "USD"}) async {
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
          return ExchangerSuccessState(currenciesResponseModel: r);
        },
      ),
    );
  }
}
