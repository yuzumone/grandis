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

Future<List<Item>> getTdlAttraction() async {
  var client = http.Client();
  var res = await client.get(
    tdlAttractionUrl,
    headers: requestHeaders,
  );

  List<dynamic> data = json.decode(res.body);
  return data.map((x) => _convertAttraction(x)).toList();
}

Future<List<Item>> getTdsAttraction() async {
  var client = http.Client();
  var res = await client.get(
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
  var client = http.Client();
  var res = await client.get(
    tdlParadeUrl,
    headers: requestHeaders,
  );
  List<dynamic> data = json.decode(res.body);
  return data.map((x) => _convertParade(x)).toList();
}

Future<List<Item>> getTdsParade() async {
  var client = http.Client();
  var res = await client.get(
    tdsParadeUrl,
    headers: requestHeaders,
  );
  List<dynamic> data = json.decode(res.body);
  return data.map((x) => _convertParade(x)).toList();
}

Parade _convertParade(Map<String, dynamic> map) {
  return Parade.fromMap(map);
}

Future<List<Item>> getTdlGreeting() async {
  var client = http.Client();
  var res = await client.get(
    tdlGreetingUrl,
    headers: requestHeaders,
  );
  var data = json.decode(res.body);
  List<Item> list = [];
  data['id11']['Facility'].forEach((x) {
    list.add(_convertGreeting(x['greeting']));
  });
  data['id13']['Facility'].forEach((x) {
    list.add(_convertGreeting(x['greeting']));
  });
  data['id16']['Facility'].forEach((x) {
    list.add(_convertGreeting(x['greeting']));
  });
  return list;
}

Future<List<Item>> getTdsGreeting() async {
  var client = http.Client();
  var res = await client.get(
    tdsGreetingUrl,
    headers: requestHeaders,
  );
  var data = json.decode(res.body);
  List<Item> list = [];
  data['id21']['Facility'].forEach((x) {
    list.add(_convertGreeting(x['greeting']));
  });
  data['id22']['Facility'].forEach((x) {
    list.add(_convertGreeting(x['greeting']));
  });
  data['id25']['Facility'].forEach((x) {
    list.add(_convertGreeting(x['greeting']));
  });
  data['id26']['Facility'].forEach((x) {
    list.add(_convertGreeting(x['greeting']));
  });
  data['id27']['Facility'].forEach((x) {
    list.add(_convertGreeting(x['greeting']));
  });
  return list;
}

Greeting _convertGreeting(Map<String, dynamic> map) {
  return Greeting.fromMap(map);
}

Future<List<Item>> getTdlRestaurant() async {
  var client = http.Client();
  var res = await client.get(
    tdlRestaurantUrl,
    headers: requestHeaders,
  );
  List<dynamic> data = json.decode(res.body);
  return data.map((x) => _convertRestaurant(x)).toList();
}

Future<List<Item>> getTdsRestaurant() async {
  var client = http.Client();
  var res = await client.get(
    tdsRestaurantUrl,
    headers: requestHeaders,
  );
  List<dynamic> data = json.decode(res.body);
  return data.map((x) => _convertRestaurant(x)).toList();
}

Restaurant _convertRestaurant(Map<String, dynamic> map) {
  return Restaurant.fromMap(map);
}

Future<List<Item>> getTdlRehabilitate() async {
  var client = http.Client();
  var res = await client.get(
    tdlRehabilitateUrl,
    headers: requestHeaders,
  );
  var doc = html.parse(res.body);
  return _parseRehabilitates(doc);
}

Future<List<Item>> getTdsRehabilitate() async {
  var client = http.Client();
  var res = await client.get(
    tdsRehabilitateUrl,
    headers: requestHeaders,
  );
  var doc = html.parse(res.body);
  return _parseRehabilitates(doc);
}

List<Rehabilitate> _parseRehabilitates(Document doc) {
  return doc
      .querySelectorAll('div.linkList6 > ul > li')
      .map((x) {
        try {
          var name = x.querySelector('p').text;
          var date =
              x.querySelector('p.date').text.replaceAll(new RegExp(r'\s'), '');
          var href = x.querySelector('a').attributes['href'];
          var url = "https://www.tokyodisneyresort.jp$href";
          return Rehabilitate(name, date, url);
        } catch (e) {
          return null;
        }
      })
      .where((x) => x != null)
      .toList();
}

Future<String> getTdlStatus() async {
  var client = http.Client();
  var res = await client.get(
    tdlStatusUrl,
    headers: requestHeaders,
  );
  var doc = html.parse(res.body);
  return doc.querySelector('p').text;
}

Future<String> getTdsStatus() async {
  var client = http.Client();
  var res = await client.get(
    tdsStatusUrl,
    headers: requestHeaders,
  );
  var doc = html.parse(res.body);
  return doc.querySelector('p').text;
}
