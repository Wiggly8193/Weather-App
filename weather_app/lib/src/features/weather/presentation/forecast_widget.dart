import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/weather_icon_image.dart';
import 'package:provider/provider.dart';

import '../application/providers.dart';

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, _) {
        final weatherItems = weatherProvider.hourlyWeatherProvider?.list ?? [];
        final items = [0,8, 16, 24, 32];
        final selectedWeatherItems = [
          for (var i in items)
            if (i < weatherItems.length) weatherItems[i]
        ];


        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: selectedWeatherItems.map((data) {
            final temp = data.temp.toInt().toString();
            return Expanded(
              child: Column(
                children: [
                  Text(
                    DateFormat('EEE').format(data.dateTime),
                    style: textTheme.bodyLarge!,
                  ),
                  WeatherIconImage(iconUrl: data.icon, size: 80),
                  Text(
                    '$temp°',
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
