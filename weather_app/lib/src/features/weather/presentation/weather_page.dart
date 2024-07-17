import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/constants/app_colors.dart';
import 'package:open_weather_example_flutter/src/features/weather/presentation/city_search_box.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../application/providers.dart';
import 'current_weather.dart';
import 'forecast_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key, required this.city});
  final String city;

  @override
  Widget build(BuildContext context) {

    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    weatherProvider.city = city;
    weatherProvider.getWeatherData();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.rainGradient,
          ),
        ),
        child:  SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              CitySearchBox(),
              ToggleSwitch(
                  minWidth: 90.0,
                  initialLabelIndex: 0,
                  cornerRadius: 20.0,
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  totalSwitches: 2,
                  labels: ['Celcius', 'Farenheit'],
                  // icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
                  activeBgColors: [[Colors.blue],[AppColors.accentColor]],
                  onToggle: (index) {
                    print('switched to: $index');
                    weatherProvider.toggleUnit();
                  },
                ),
              Spacer(),
              Expanded(child: CurrentWeather()),
              Spacer(),
              Expanded(child: ForecastWidget()),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
