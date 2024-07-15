import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../../data/model/currencies_response_model.dart';

abstract class Repository{
  Future<Either<Failure,CurrenciesResponseModel>> splash(Map<String, dynamic> data);
}