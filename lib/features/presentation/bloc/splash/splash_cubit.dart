import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../error/failures.dart';
import '../../../domain/usecases/splash_usecase.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final Splash splash;

  SplashCubit({required this.splash}) : super(SplashInitial());

  Future<dynamic> getSplashData() async {
    emit(ApiLoadingState());
    final result = await splash({"A":"B"});

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
          return SplashSuccessState();
        },
      ),
    );
  }
}
