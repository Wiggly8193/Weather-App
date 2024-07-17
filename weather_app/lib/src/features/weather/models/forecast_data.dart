import 'dart:convert';

import 'forecast_detail.dart';

class ForecastData {
  final List<ForecastDetail> list;

  ForecastData({
    required this.list,
  });

  factory ForecastData.fromRawJson(String str) =>
      ForecastData.fromJson(json.decode(str));

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    List<ForecastDetail> forecastList =
    list.map((i) => ForecastDetail.fromJson(i)).toList();
    return ForecastData(list: forecastList);
  }

}