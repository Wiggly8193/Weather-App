class ForecastDetail {
  final DateTime dateTime;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String mainWeather;
  final String description;
  final String icon;

  ForecastDetail({
    required this.dateTime,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.mainWeather,
    required this.description,
    required this.icon,
  });

  factory ForecastDetail.fromJson(Map<String, dynamic> json) => ForecastDetail(
    dateTime: DateTime.parse(json["dt_txt"]),
    temp: json["main"]["temp"].toDouble(),
    tempMin: json["main"]["temp_min"].toDouble(),
    tempMax: json["main"]["temp_max"].toDouble(),
    mainWeather: json["weather"][0]["main"],
    description: json["weather"][0]["description"],
    icon: json["weather"][0]["icon"],
  );

  Map<String, dynamic> toJson() => {
    "dt_txt": dateTime.toIso8601String(),
    "main": {
      "temp": temp,
      "temp_min": tempMin,
      "temp_max": tempMax,
    },
    "weather": [
      {"main": mainWeather, "description": description, "icon": icon}
    ],
  };
}