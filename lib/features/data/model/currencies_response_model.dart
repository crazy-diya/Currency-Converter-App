// To parse this JSON data, do
//
//     final currenciesResponseModel = currenciesResponseModelFromJson(jsonString);

import 'dart:convert';

CurrenciesResponseModel currenciesResponseModelFromJson(String str) => CurrenciesResponseModel.fromJson(json.decode(str));

String currenciesResponseModelToJson(CurrenciesResponseModel data) => json.encode(data.toJson());

class CurrenciesResponseModel {
  final Map<String, double>? data;

  CurrenciesResponseModel({
    this.data,
  });

  factory CurrenciesResponseModel.fromJson(Map<String, dynamic> json) => CurrenciesResponseModel(
    data: Map.from(json["data"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "data": Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
