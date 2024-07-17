
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/api/api_keys.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/weather_repository.dart';

import '../models/forecast_data.dart';
import '../models/weather_data.dart';

enum WeatherState { initial, loading, loaded, error }

class WeatherProvider extends ChangeNotifier {
  HttpWeatherRepository repository = HttpWeatherRepository(
    api: OpenWeatherMapAPI(sl<String>(instanceName: 'api_key')),
    client: http.Client(),
  );

  String city = 'London';
  WeatherData? currentWeatherProvider;
  ForecastData? hourlyWeatherProvider;
  WeatherState _state = WeatherState.initial;
  String? _errorMessage;

  bool isCelsius = true;

  String get unit => isCelsius ? 'metric' : 'imperial';
  WeatherState get state => _state;
  String? get errorMessage => _errorMessage;

  Future<void> getWeatherData() async {
    //TODO set the weather and fetch forecast after
    _state = WeatherState.loading;
    notifyListeners();
    try {
      final weather = await repository.getWeather(city: city, unit: unit);
      currentWeatherProvider = weather;
      _state = WeatherState.loaded;
      _errorMessage = null;
      notifyListeners();
      await getForecastData();
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> getForecastData() async {
    //TODO set the forecast
    try {
      final forecast = await repository.getForecast(city: city, unit: unit);
      hourlyWeatherProvider = forecast;
      notifyListeners();
    } catch (e) {
      _state = WeatherState.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void toggleUnit() {
    isCelsius = !isCelsius;
    getWeatherData();
  }
}
