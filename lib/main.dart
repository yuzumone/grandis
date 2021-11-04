import 'package:flutter/material.dart';
import 'package:grandis/data/model/item.dart';
import 'package:grandis/data/model/park_type.dart';
import 'package:grandis/data/repository/tdr_repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';

final attractionTitle = 'attraction';
final paradeTitle = 'parade';
final greetingTitle = 'greeting';
final restaurantTitle = 'restaurant';
final rehabilitateTitle = 'rehabilirate';

void main() {
  runApp(MaterialApp(
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('ja', ''),
    ],
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomePage(),
    routes: <String, WidgetBuilder>{
      '/tdl': (_) => TdlPage(),
      '/tds': (_) => TdsPage(),
    },
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class TdlPage extends StatefulWidget {
  @override
  _TdlPageState createState() => _TdlPageState();
}

class TdsPage extends StatefulWidget {
  @override
  _TdsPageState createState() => _TdsPageState();
}

class _HomePageState extends State<HomePage> {
  String _tdlStatus = '';
  String _tdsStatus = '';

  @override
  void initState() {
    super.initState();
    var client = TdrRepository(client: http.Client());
    client.getStatus(ParkType.TDL).then((status) {
      setState(() {
        _tdlStatus = status;
      });
    });
    client.getStatus(ParkType.TDS).then((status) {
      setState(() {
        _tdsStatus = status;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grandis'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/tdl');
                    },
                    child: Text(
                      'ディズニーランド',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/tds');
                    },
                    child: Text(
                      'ディズニーシー',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: SizedBox.expand(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Text('当日券販売状況'),
                    ),
                    Text(
                      _tdlStatus,
                    ),
                    Text(
                      _tdsStatus,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TdlPageState extends State<TdlPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  Map<String, List<Item?>> items = {
    attractionTitle: [],
    paradeTitle: [],
    greetingTitle: [],
    restaurantTitle: [],
    rehabilitateTitle: [],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
    var client = TdrRepository(client: http.Client());
    final type = ParkType.TDL;
    client.getAttraction(type).then((attractions) {
      setState(() {
        items[attractionTitle] = attractions;
      });
    });
    client.getParade(type).then((parades) {
      setState(() {
        items[paradeTitle] = parades;
      });
    });
    client.getGreeting(type).then((greetings) {
      setState(() {
        items[greetingTitle] = greetings;
      });
    });
    client.getRestaurant(type).then((restaurants) {
      setState(() {
        items[restaurantTitle] = restaurants;
      });
    });
    client.getRehabilitate(type).then((rehabilitates) {
      rehabilitates.forEach((x) {
        setState(() {
          items[rehabilitateTitle] = rehabilitates;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ディズニーランド'),
        backgroundColor: Colors.pink,
        bottom: TabBar(
          tabs: _createTabs(items),
          controller: _tabController,
          indicatorColor: Colors.white,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:
            items.keys.map((title) => _createTabBarView(title, items)).toList(),
      ),
    );
  }
}

class _TdsPageState extends State<TdsPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  Map<String, List<Item?>> items = {
    attractionTitle: [],
    paradeTitle: [],
    greetingTitle: [],
    restaurantTitle: [],
    rehabilitateTitle: [],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
    var client = TdrRepository(client: http.Client());
    var type = ParkType.TDS;
    client.getAttraction(type).then((attractions) {
      setState(() {
        items[attractionTitle] = attractions;
      });
    });
    client.getParade(type).then((parades) {
      setState(() {
        items[paradeTitle] = parades;
      });
    });
    client.getGreeting(type).then((greetings) {
      setState(() {
        items[greetingTitle] = greetings;
      });
    });
    client.getRestaurant(type).then((restaurants) {
      setState(() {
        items[restaurantTitle] = restaurants;
      });
    });
    client.getRehabilitate(type).then((rehabilitates) {
      setState(() {
        items[rehabilitateTitle] = rehabilitates;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ディズニーシー'),
        bottom: TabBar(
          tabs: _createTabs(items),
          controller: _tabController,
          indicatorColor: Colors.white,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:
            items.keys.map((title) => _createTabBarView(title, items)).toList(),
      ),
    );
  }
}

List<Tab> _createTabs(Map<String, List<Item?>> items) {
  var _list = <Tab>[];
  items.forEach((title, item) {
    _list.add(Tab(text: title));
  });
  return _list;
}

Widget _createTabBarView(String title, Map<String, List<Item?>> items) {
  var _list = items[title]!;
  return Container(
    child: ListView.builder(
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        var item = _list[index]!;
        return ListTile(
          title: Text(item.getTitle()),
          subtitle: Text(item.getSubTitle()),
        );
      },
    ),
  );
}
