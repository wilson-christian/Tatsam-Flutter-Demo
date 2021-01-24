import 'package:http/http.dart' as http;
import 'package:tatsum_demo/http/url.dart';

class ApiRequest {
  final String urlEndPoint;
  final dynamic body;

  ApiRequest(this.urlEndPoint, this.body);

  Future<http.Response> get() {
    return http.get(urlBase + urlEndPoint).timeout(Duration(minutes: 2));
  }
}
