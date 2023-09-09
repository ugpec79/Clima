import 'package:http/http.dart';

class Weather {
  Future<Response> getData(double long, double lat) async {
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=58b7ed659938bcd3c2c1be1c4cf0e6e6"));
    return response;
  }

  Future<Response> getDataOfCity(String city) async {
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=58b7ed659938bcd3c2c1be1c4cf0e6e6"));
    return response;
  }
}
