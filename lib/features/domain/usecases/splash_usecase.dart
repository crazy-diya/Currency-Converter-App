import 'package:currency_converter_app/features/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';
import '../repository/repository.dart';

class Splash extends UseCase<dynamic, Map<String, dynamic>> {
  final Repository repository;

  Splash({required this.repository});

  @override
  Future<Either<Failure, dynamic>> call(Map<String, dynamic> params) async {
    return await repository.splash(params);
  }
}
