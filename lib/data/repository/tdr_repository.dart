import 'package:grandis/data/model/attraction.dart';
import 'package:grandis/data/model/goods.dart';
import 'package:grandis/data/model/greeting.dart';
import 'package:grandis/data/model/item.dart';
import 'package:grandis/data/model/parade.dart';
import 'package:grandis/data/model/park_type.dart';
import 'package:grandis/data/model/rehabilitate.dart';
import 'package:grandis/data/model/restaurant.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart';
import 'dart:async';
import 'dart:convert';

final tdrRepositoryProvider = Provider((_) => TdrRepository(client: Client()));

class TdrRepository {
  final String _tdlAttractionUrl =
      'https://www.tokyodisneyresort.jp/_/realtime/tdl_attraction.json';
  final String _tdsAttractionUrl =
      'https://www.tokyodisneyresort.jp/_/realtime/tds_attraction.json';
  final String _tdlParadeUrl =
      'https://www.tokyodisneyresort.jp/_/realtime/tdl_parade_show.json';
  final String _tdsParadeUrl =
      'https://www.tokyodisneyresort.jp/_/realtime/tds_parade_show.json';
  final String _tdlGreetingUrl =
      'https://www.tokyodisneyresort.jp/_/realtime/tdl_greeting.json';
  final String _tdsGreetingUrl =
      'https://www.tokyodisneyresort.jp/_/realtime/tds_greeting.json';
  final String _tdlRestaurantUrl =
      'https://www.tokyodisneyresort.jp/_/realtime/tdl_restaurant.json';
  final String _tdsRestaurantUrl =
      'https://www.tokyodisneyresort.jp/_/realtime/tds_restaurant.json';
  final String _tdlRehabilitateUrl =
      'https://www.tokyodisneyresort.jp/tdl/monthly/stop.html';
  final String _tdsRehabilitateUrl =
      'https://www.tokyodisneyresort.jp/tds/monthly/stop.html';
  final String _tdlStatusUrl = 'https://www.tokyodisneyresort.jp/tdl/';
  final String _tdsStatusUrl = 'https://www.tokyodisneyresort.jp/tds/';
  final String _tdlSoonUrl =
      'https://www.tokyodisneyresort.jp/view_interface.php?blockId=94199&pageBlockId=2084564';
  final String _tdsSoonUrl =
      'https://www.tokyodisneyresort.jp/view_interface.php?blockId=94199&pageBlockId=2084606';
  final String _tdlNewUrl =
      'https://www.tokyodisneyresort.jp/view_interface.php?blockId=94199&pageBlockId=2084578';
  final String _tdsNewUrl =
      'https://www.tokyodisneyresort.jp/view_interface.php?blockId=94199&pageBlockId=2084634';
  final Map<String, String> _requestHeaders = {
    'User-Agent':
        'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36',
    'Accept':
        'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'ja',
    'Upgrade-Insecure-Requests': '1',
    'Connection': 'keep-alive'
  };
  final Client client;

  TdrRepository({required this.client});

  String _getAttractionUrl(ParkType type) {
    switch (type) {
      case ParkType.TDL:
        return _tdlAttractionUrl;
      case ParkType.TDS:
        return _tdsAttractionUrl;
    }
  }

  Future<List<Item>> getAttraction(ParkType type) async {
    final url = _getAttractionUrl(type);
    final res = await client.get(
      Uri.parse(url),
      headers: _requestHeaders,
    );
    final List<dynamic> data = json.decode(res.body);
    return data.map((x) => Attraction.fromJson(x)).toList();
  }

  String _getParadeUrl(ParkType type) {
    switch (type) {
      case ParkType.TDL:
        return _tdlParadeUrl;
      case ParkType.TDS:
        return _tdsParadeUrl;
    }
  }

  Future<List<Item>> getParade(ParkType type) async {
    final url = _getParadeUrl(type);
    final res = await client.get(
      Uri.parse(url),
      headers: _requestHeaders,
    );
    final List<dynamic> data = json.decode(res.body);
    return data.map((x) => Parade.fromJson(x)).toList();
  }

  String _getGreetingUrl(ParkType type) {
    switch (type) {
      case ParkType.TDL:
        return _tdlGreetingUrl;
      case ParkType.TDS:
        return _tdsGreetingUrl;
    }
  }

  Future<List<Item>> getGreeting(ParkType type) async {
    final url = _getGreetingUrl(type);
    final res = await client.get(
      Uri.parse(url),
      headers: _requestHeaders,
    );
    final data = json.decode(res.body);
    final list = <Item>[];
    data.forEach((k, v) {
      final facility = v['Facility'];
      facility.forEach((x) => list.add(Greeting.fromJson(x['greeting'])));
    });
    return list;
  }

  String _getRestaurantUrl(ParkType type) {
    switch (type) {
      case ParkType.TDL:
        return _tdlRestaurantUrl;
      case ParkType.TDS:
        return _tdsRestaurantUrl;
    }
  }

  Future<List<Item>> getRestaurant(ParkType type) async {
    final url = _getRestaurantUrl(type);
    var res = await client.get(
      Uri.parse(url),
      headers: _requestHeaders,
    );
    final List<dynamic> data = json.decode(res.body);
    return data.map((x) => Restaurant.fromJson(x)).toList();
  }

  String _getRehabilirateUrl(ParkType type) {
    switch (type) {
      case ParkType.TDL:
        return _tdlRehabilitateUrl;
      case ParkType.TDS:
        return _tdsRehabilitateUrl;
    }
  }

  Future<List<Item>> getRehabilitate(ParkType type) async {
    final url = _getRehabilirateUrl(type);
    final res = await client.get(
      Uri.parse(url),
      headers: _requestHeaders,
    );
    final doc = html.parse(utf8.decode(res.bodyBytes));
    return _parseRehabilitates(doc);
  }

  List<Rehabilitate> _parseRehabilitates(Document doc) {
    var result = <Rehabilitate>[];
    for (var item in doc.querySelectorAll('div.linkList > ul > li')) {
      try {
        final name = item.querySelector('p.heading3')?.text;
        final date = item
            .querySelectorAll('p')[1]
            .text
            .replaceAll(RegExp('(\t|\n)'), '');
        if (name != null) {
          result.add(Rehabilitate(name, date));
        }
      } catch (e) {
        continue;
      }
    }
    return result;
  }

  String _getStatusUrl(ParkType type) {
    switch (type) {
      case ParkType.TDL:
        return _tdlStatusUrl;
      case ParkType.TDS:
        return _tdsStatusUrl;
    }
  }

  Future<String> getStatus(ParkType type) async {
    final url = _getStatusUrl(type);
    final res = await client.get(
      Uri.parse(url),
      headers: _requestHeaders,
    );
    final doc = html.parse(res.body).querySelector('div.state-left');
    final body = <String>[];
    for (var item in doc?.querySelectorAll('dl') ?? []) {
      body.add(
          '${item.querySelector("dt").text}: ${item.querySelector("dd").text.trim()}');
    }
    return body.isNotEmpty ? body.join('\n') : '';
  }

  String _getNewUrl(ParkType type) {
    switch (type) {
      case ParkType.TDL:
        return _tdlNewUrl;
      case ParkType.TDS:
        return _tdsNewUrl;
    }
  }

  Future<List<Item>> getNewGoods(ParkType type) async {
    var offset = 0;
    var goods = <Goods>[];
    final url = _getNewUrl(type);
    do {
      final res = await client.get(
        Uri.parse('$url&offset=$offset'),
        headers: _requestHeaders,
      );
      final doc = html.parse(utf8.decode(res.bodyBytes));
      final list = doc.querySelectorAll('li');
      goods.addAll(_parseGoods(list));
      if (list.isEmpty) {
        break;
      }
      offset += list.length;
    } while (offset % 48 == 0);
    return goods;
  }

  String _getSoonUrl(ParkType type) {
    switch (type) {
      case ParkType.TDL:
        return _tdlSoonUrl;
      case ParkType.TDS:
        return _tdsSoonUrl;
    }
  }

  Future<List<Item>> getSoon(ParkType type) async {
    var offset = 0;
    var goods = <Goods>[];
    final url = _getSoonUrl(type);
    do {
      final res = await client.get(
        Uri.parse('$url&offset=$offset'),
        headers: _requestHeaders,
      );
      final doc = html.parse(utf8.decode(res.bodyBytes));
      final list = doc.querySelectorAll('li');
      goods.addAll(_parseGoods(list));
      if (list.isEmpty) {
        break;
      }
      offset += list.length;
    } while (offset % 48 == 0);
    return goods;
  }

  List<Goods> _parseGoods(List<Element> list) {
    var goods = <Goods>[];
    for (var g in list) {
      final name = g.querySelector('span')?.text;
      final price = g.querySelector('p.price')?.text;
      final href = g.querySelector('a')?.attributes['href'];
      final regexp = RegExp('(.+より販売開始)');
      final date = regexp.firstMatch(g.text)?.group(1)?.trim();
      final url = 'https://www.tokyodisneyresort.jp$href';
      final image = g.querySelector('img')?.attributes['src'];
      if (name != null && price != null && href != null && image != null) {
        goods.add(Goods(name, url, image, price, date));
      }
    }
    return goods;
  }
}
