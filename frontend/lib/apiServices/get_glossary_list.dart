import 'package:http/http.dart' as http;
import 'package:rocketdictionary/const.dart';

Future<http.Response> backendGetGlossaryList() {
  Future<http.Response> response = http.get(Uri.parse('$kBackendURL/glossary'));
  return response;
}
