import 'package:http/http.dart';

class Weather {
  Future<Response> getData(double long, double lat) async {
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid="));
    return response;
  }

  Future<Response> getDataOfCity(String city) async {
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid="));
    return response;
  }
}
