import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/features/weather/models/weather_data.dart';

import '../models/forecast_data.dart';
import 'api_exception.dart';

class HttpWeatherRepository{

  final OpenWeatherMapAPI api;
  final http.Client client;

  HttpWeatherRepository({required this.api, required this.client});

  Future<ForecastData> getForecast({required String city, required unit}) async {
    final uri = api.forecast(city, unit);
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return ForecastData.fromJson(data);
        case 401:
          throw InvalidApiKeyException();
        case 404:
          throw CityNotFoundException();
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }

  Future<WeatherData> getWeather({required String city, required String unit}) async {
    final uri = api.weather(city, unit);
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return WeatherData.fromJson(data);
        case 401:
          throw InvalidApiKeyException();
        case 404:
          throw CityNotFoundException();
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}
