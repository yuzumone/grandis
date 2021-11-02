import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart';
import 'dart:async';
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
final String tdlGreetingUrl =
    'https://www.tokyodisneyresort.jp/_/realtime/tdl_greeting.json';
final String tdsGreetingUrl =
    'https://www.tokyodisneyresort.jp/_/realtime/tds_greeting.json';
final String tdlRestaurantUrl =
    'https://www.tokyodisneyresort.jp/_/realtime/tdl_restaurant.json';
final String tdsRestaurantUrl =
    'https://www.tokyodisneyresort.jp/_/realtime/tds_restaurant.json';
final String tdlRehabilitateUrl =
    'https://www.tokyodisneyresort.jp/tdl/monthly/stop.html';
final String tdsRehabilitateUrl =
    'https://www.tokyodisneyresort.jp/tds/monthly/stop.html';
final String tdlStatusUrl =
    'https://www.tokyodisneyresort.jp/view_interface.php?blockId=94199&pageBlockId=135360';
final String tdsStatusUrl =
    'https://www.tokyodisneyresort.jp/view_interface.php?blockId=94199&pageBlockId=135410';
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

class TdrClient {
  http.Client client;

  TdrClient(this.client);

  Future<List<Item>> getTdlAttraction() async {
    final uri = Uri.parse(tdlAttractionUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    List<dynamic> data = json.decode(res.body);
    return data.map((x) => _convertAttraction(x)).toList();
  }

  Future<List<Item>> getTdsAttraction() async {
    final uri = Uri.parse(tdsAttractionUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    List<dynamic> data = json.decode(res.body);
    return data.map((x) => _convertAttraction(x)).toList();
  }

  Attraction _convertAttraction(Map<String, dynamic> map) {
    return Attraction.fromMap(map);
  }

  Future<List<Item>> getTdlParade() async {
    final uri = Uri.parse(tdlParadeUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    List<dynamic> data = json.decode(res.body);
    return data.map((x) => _convertParade(x)).toList();
  }

  Future<List<Item>> getTdsParade() async {
    final uri = Uri.parse(tdsParadeUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    List<dynamic> data = json.decode(res.body);
    return data.map((x) => _convertParade(x)).toList();
  }

  Parade _convertParade(Map<String, dynamic> map) {
    return Parade.fromMap(map);
  }

  Future<List<Item>> getTdlGreeting() async {
    final uri = Uri.parse(tdlGreetingUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    var data = json.decode(res.body);
    var list = <Item>[];
    data.forEach((k, v) {
      var facility = v['Facility'];
      facility.forEach((x) => list.add(_convertGreeting(x['greeting'])));
    });
    return list;
  }

  Future<List<Item>> getTdsGreeting() async {
    final uri = Uri.parse(tdsGreetingUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    var data = json.decode(res.body);
    var list = <Item>[];
    data.forEach((k, v) {
      var facility = v['Facility'];
      facility.forEach((x) => list.add(_convertGreeting(x['greeting'])));
    });
    return list;
  }

  Greeting _convertGreeting(Map<String, dynamic> map) {
    return Greeting.fromMap(map);
  }

  Future<List<Item>> getTdlRestaurant() async {
    final uri = Uri.parse(tdsRestaurantUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    List<dynamic> data = json.decode(res.body);
    return data.map((x) => _convertRestaurant(x)).toList();
  }

  Future<List<Item>> getTdsRestaurant() async {
    final uri = Uri.parse(tdsRestaurantUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    List<dynamic> data = json.decode(res.body);
    return data.map((x) => _convertRestaurant(x)).toList();
  }

  Restaurant _convertRestaurant(Map<String, dynamic> map) {
    return Restaurant.fromMap(map);
  }

  Future<List<Item>> getTdlRehabilitate() async {
    final uri = Uri.parse(tdlRehabilitateUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    var doc = html.parse(res.body);
    return _parseRehabilitates(doc);
  }

  Future<List<Item>> getTdsRehabilitate() async {
    final uri = Uri.parse(tdsRehabilitateUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    var doc = html.parse(res.body);
    return _parseRehabilitates(doc);
  }

  List<Rehabilitate> _parseRehabilitates(Document doc) {
    var result = <Rehabilitate>[];
    for (var item in doc.querySelectorAll('div.linkList6 > ul > li')) {
      try {
        final name = item.querySelector('p')?.text;
        final date =
            item.querySelector('p.date')?.text.replaceAll(RegExp(r'\s'), '');
        if (name != null && date != null) {
          result.add(Rehabilitate(name, date));
        }
      } catch (e) {
        return result;
      }
    }
    return result;
  }

  Future<String> getTdlStatus() async {
    final uri = Uri.parse(tdlStatusUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    var doc = html.parse(res.body);
    return doc.querySelector('p')!.text;
  }

  Future<String> getTdsStatus() async {
    final uri = Uri.parse(tdsStatusUrl);
    var res = await client.get(
      uri,
      headers: requestHeaders,
    );
    var doc = html.parse(res.body);
    return doc.querySelector('p')!.text;
  }
}
