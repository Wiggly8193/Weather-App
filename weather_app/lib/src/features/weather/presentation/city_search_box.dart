import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/constants/app_colors.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:provider/provider.dart';

class CitySearchBox extends StatefulWidget {
  const CitySearchBox({super.key});

  @override
  State<CitySearchBox> createState() => _CitySearchRowState();
}

class _CitySearchRowState extends State<CitySearchBox> {
  static const _radius = 30.0;

  late final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = context.read<WeatherProvider>().city;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // circular radius
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: _radius * 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                //TODO make component functional and add style
                controller: _searchController,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_radius),
                      bottomLeft: Radius.circular(_radius),
                    ),
                  ),
                ),
                onSubmitted: (value) async {
                  if (value.isNotEmpty) {
                    final provider = context.read<WeatherProvider>();
                    provider.city = value;
                    await provider.getWeatherData();
                  }
                },
              ),
            ),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(_radius),
                    bottomRight: Radius.circular(_radius),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text('search',
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ),
              onTap: () async {
                FocusScope.of(context).unfocus();
                final provider = context.read<WeatherProvider>();
                provider.city = _searchController.text;
                await provider.getWeatherData();
              },
            )
          ],
        ),
      ),
    );
  }
}
