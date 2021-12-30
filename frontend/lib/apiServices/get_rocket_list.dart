import 'package:http/http.dart' as http;
import 'package:rocketdictionary/const.dart';

Future<http.Response> backendGetRocketList() {
  Future<http.Response> response = http.get(Uri.parse('$kBackendURL/rockets'));
  return response;
}
