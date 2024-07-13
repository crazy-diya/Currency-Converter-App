
import '../../../core/network/api_helper.dart';

abstract class RemoteDatasource {
  Future<dynamic> splashRequest(Map<String, dynamic> data);
}

class RemoteDatasourceImpl extends RemoteDatasource {
  final APIHelper apiHelper;

  RemoteDatasourceImpl({required this.apiHelper});

  @override
  Future<dynamic> splashRequest(Map<String, dynamic> data) async {
    try {
      final response = await apiHelper.get({"b": "", "a": ""});
      return response;
      /**Here you can use Model class cast things from json to object*/
    } on Exception {
      rethrow;
    }
  }
}
