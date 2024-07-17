import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WeatherIconImage extends StatelessWidget {
  const WeatherIconImage(
      {super.key, required this.iconUrl, required this.size});
  final String iconUrl;
  final double size;

  @override
  Widget build(BuildContext context) {

    if (iconUrl.isEmpty) {
      return const Icon(Icons.error_outline);
    }

    String iconImageUrl = 'https://openweathermap.org/img/wn/$iconUrl@2x.png';
    return Expanded(
      child: CachedNetworkImage(
        imageUrl: iconImageUrl,
        width: 120,
        height: 120,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
