part of 'exchanger_cubit.dart';

@immutable
abstract class ExchangerState {}

class ExchangerInitial extends ExchangerState {}

class ApiLoadingState extends ExchangerState {}

class ApiFailureState extends ExchangerState {}

class DioExceptionFailureState extends ExchangerState {}

class ServerFailureState extends ExchangerState {}

class ConnectionFailureState extends ExchangerState {}

class ExchangerSuccessState extends ExchangerState {
  final CurrenciesResponseModel ?currenciesResponseModel;

  ExchangerSuccessState({required this.currenciesResponseModel});
}