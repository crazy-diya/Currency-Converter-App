import 'package:currency_converter_app/features/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../data/model/currencies_response_model.dart';
import '../repository/repository.dart';

class Splash extends UseCase<CurrenciesResponseModel, Map<String, dynamic>> {
  final Repository repository;

  Splash({required this.repository});

  @override
  Future<Either<Failure, CurrenciesResponseModel>> call(Map<String, dynamic> params) async {
    return await repository.splash(params);
  }
}
