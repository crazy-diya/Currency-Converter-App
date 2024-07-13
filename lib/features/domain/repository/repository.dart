import 'package:dartz/dartz.dart';

import '../../../error/failures.dart';

abstract class Repository{
  Future<Either<Failure,dynamic>> splash(Map<String, dynamic> data);
}