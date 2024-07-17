/// Uri builder class for the OpenWeatherMap API
class OpenWeatherMapAPI {
  OpenWeatherMapAPI(this.apiKey);

  final String apiKey;

  static const String _apiBaseUrl = "api.openweathermap.org";
  static const String _apiPath = "/data/2.5/";

  Uri weather(String city, String unit) => _buildUri(
        endpoint: "weather",
        parametersBuilder: () => cityQueryParameters(city, unit),
      );

  Uri forecast(String city, String unit) => _buildUri(
        endpoint: "forecast",
        parametersBuilder: () => cityQueryParameters(city, unit),
      );

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: _apiBaseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  Map<String, dynamic> cityQueryParameters(String city, unit) => {
        "q": city,
        "appid": apiKey,
        "units": unit,
        "type": "like",
        "cnt": "30",
      };
}
