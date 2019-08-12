import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model.dart';

final String tdlAttractionUrl =
    'https://www.tokyodisneyresort.jp/_/realtime/tdl_attraction.json';
final String tdsAttractionUrl =
    'https://www.tokyodisneyresort.jp/_/realtime/tds_attraction.json';
final String tdlParadeUrl =
    'https://www.tokyodisneyresort.jp/_/realtime/tdl_parade_show.json';
final String tdsParadeUrl =
    'https://www.tokyodisneyresort.jp/_/realtime/tds_parade_show.json';
final Map<String, String> requestHeaders = {
  'User-Agent':
      'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36',
  'Accept':
      'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
  'Accept-Encoding': 'gzip, deflate, br',
  'Accept-Language': 'ja',
  'Upgrade-Insecure-Requests': '1',
  'Connection': 'keep-alive'
};

Future<List<Item>> getTdlAttraction() async {
  var res = await http.get(
    tdlAttractionUrl,
    headers: requestHeaders,
  );
  List<dynamic> data = json.decode(res.body);
  return data.map((x) => _convertAttraction(x)).toList();
}

Future<List<Item>> getTdsAttraction() async {
  var res = await http.get(
    tdsAttractionUrl,
    headers: requestHeaders,
  );
  List<dynamic> data = json.decode(res.body);
  return data.map((x) => _convertAttraction(x)).toList();
}

Attraction _convertAttraction(Map<String, dynamic> map) {
  return Attraction.fromMap(map);
}

Future<List<Item>> getTdlParade() async {
  var res = await http.get(
    tdlParadeUrl,
    headers: requestHeaders,
  );
  List<dynamic> data = json.decode(res.body);
  return data.map((x) => _convertParade(x)).toList();
}

Future<List<Item>> getTdsParade() async {
  var res = await http.get(
    tdsParadeUrl,
    headers: requestHeaders,
  );
  List<dynamic> data = json.decode(res.body);
  return data.map((x) => _convertParade(x)).toList();
}

Parade _convertParade(Map<String, dynamic> map) {
  return Parade.fromMap(map);
}
