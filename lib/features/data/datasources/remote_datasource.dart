import 'package:currency_converter_app/features/data/model/currencies_response_model.dart';

import '../../../core/network/api_helper.dart';

abstract class RemoteDatasource {
  Future<CurrenciesResponseModel> splashRequest(Map<String, dynamic> data);
}

class RemoteDatasourceImpl extends RemoteDatasource {
  final APIHelper apiHelper;

  RemoteDatasourceImpl({required this.apiHelper});

  @override
  Future<CurrenciesResponseModel> splashRequest(Map<String, dynamic> data) async {
    try {
      final response = await apiHelper.get(
        "latest/",
        param: data,
      );
      return CurrenciesResponseModel.fromJson(response);
    } on Exception {
      rethrow;
    }
  }
}
