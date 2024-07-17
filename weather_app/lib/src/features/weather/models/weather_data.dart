import 'dart:convert';

import 'package:open_weather_example_flutter/src/features/weather/models/weather.dart';

class WeatherData {
  final List<Weather> weather;
  final Main main;
  final String name;

  WeatherData({
    required this.weather,
    required this.main,
    required this.name,
  });


  String toRawJson() => json.encode(toJson());

  factory WeatherData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw FormatException("Invalid JSON data");
    }

    // Ensure weather field is handled gracefully
    List<Weather> parsedWeather = [];
    if (json['weather'] != null && json['weather'] is List) {
      parsedWeather =
      List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x)));
    }

    return WeatherData(
      weather: parsedWeather,
      main: Main.fromJson(json["main"] ?? {}),
      name: json["name"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
    "main": main.toJson(),
    "name": name,
  };
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
  });

  factory Main.fromRawJson(String str) =>
      Main.fromJson(json.decode(str) ?? {});

  String toRawJson() => json.encode(toJson());

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: (json["temp"] ?? 0.0).toDouble(),
      feelsLike: (json["feels_like"] ?? 0.0).toDouble(),
      tempMin: (json["temp_min"] ?? 0.0).toDouble(),
      tempMax: (json["temp_max"] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
  };
}
