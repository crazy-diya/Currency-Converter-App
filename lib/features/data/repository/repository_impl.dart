import 'package:dartz/dartz.dart';
import '../../../core/network/network_info.dart';
import '../../../error/exception.dart';
import '../../../error/failures.dart';
import '../../domain/entities/error_response_entity.dart';
import '../../domain/repository/repository.dart';
import '../datasources/remote_datasource.dart';

class RepositoryImpl extends Repository {
  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  RepositoryImpl({required this.remoteDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, dynamic>> splash(Map<String, dynamic> data) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.splashRequest(data);
        return Right(response);
      } on DioExceptionError catch (e) {
        return Left(DioExceptionFailure(e.errorResponse!));
      } on Exception catch (e) {
        return Left(
          ServerFailure(
            errorResponse: ErrorResponseEntity(
              responseCode: "",
              responseError: e.toString(),
            ),
          ),
        );
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
