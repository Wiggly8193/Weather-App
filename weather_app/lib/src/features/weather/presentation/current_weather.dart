import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/forecast_widget.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_icon_image.dart';
import 'package:provider/provider.dart';

import '../application/providers.dart';
import '../models/weather_data.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<WeatherProvider,
            (String city, WeatherData? weatherData, WeatherState, String?)>(
        selector: (context, provider) => (
              provider.city,
              provider.currentWeatherProvider,
              provider.state,
              provider.errorMessage
            ),
        builder: (context, data, _) {
          final city = data.$1;
          final weatherData = data.$2;
          final state = data.$3;
          final errorMessage = data.$4;

          Widget content;

          //TODO account for null, errors and loading states

          switch (state) {
            case WeatherState.initial:
              content = Text('Enter a city to get the weather.',
                  style: Theme.of(context).textTheme.bodyMedium);
              break;
            case WeatherState.loading:
              content = CircularProgressIndicator();
              break;
            case WeatherState.loaded:
              if (weatherData != null) {
                content = CurrentWeatherContents(data: weatherData);
              } else {
                content = Text('No weather data available.',
                    style: Theme.of(context).textTheme.bodyMedium);
              }
              break;
            case WeatherState.error:
              content = Text('Error: $errorMessage',
                  style: Theme.of(context).textTheme.bodyMedium);
              break;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(data.$1, style: Theme.of(context).textTheme.headlineMedium),
              content,
            ],
          );
        });
  }
}

class CurrentWeatherContents extends StatelessWidget {
  const CurrentWeatherContents({super.key, required this.data});

  final WeatherData? data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data?.main.temp.toInt().toString();
    final minTemp = data?.main.tempMin.toInt().toString();
    final maxTemp = data?.main.tempMax.toInt().toString();
    final highAndLow = 'H:$maxTemp° L:$minTemp°';
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WeatherIconImage(iconUrl: data!.weather.first.icon, size: 120),
          Text(temp!, style: textTheme.displayMedium),
          Text(highAndLow, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}
