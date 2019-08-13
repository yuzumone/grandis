import 'package:flutter/material.dart';
import 'api.dart';
import 'model.dart';

final attractionTitle = 'attraction';
final paradeTitle = 'parade';
final greetingTitle = 'greeting';
final restaurantTitle = 'restaurant';

void main() {
  runApp(MaterialApp(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grandis'),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.pink,
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
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _TdlPageState extends State<TdlPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  Map<String, List<Item>> items = {
    attractionTitle: [],
    paradeTitle: [],
    greetingTitle: [],
    restaurantTitle: [],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
    getTdlAttraction().then((attractions) {
      setState(() {
        items[attractionTitle] = attractions;
      });
    });
    getTdlParade().then((parades) {
      setState(() {
        items[paradeTitle] = parades;
      });
    });
    getTdlGreeting().then((greetings) {
      setState(() {
        items[greetingTitle] = greetings;
      });
    });
    getTdlRestaurant().then((restaurants) {
      setState(() {
        items[restaurantTitle] = restaurants;
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
  TabController _tabController;
  Map<String, List<Item>> items = {
    attractionTitle: [],
    paradeTitle: [],
    greetingTitle: [],
    restaurantTitle: [],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
    getTdsAttraction().then((attractions) {
      setState(() {
        items[attractionTitle] = attractions;
      });
    });
    getTdsParade().then((parades) {
      setState(() {
        items[paradeTitle] = parades;
      });
    });
    getTdsGreeting().then((greetings) {
      setState(() {
        items[greetingTitle] = greetings;
      });
    });
    getTdsRestaurant().then((restaurants) {
      setState(() {
        items[restaurantTitle] = restaurants;
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

List<Tab> _createTabs(Map<String, List<Item>> items) {
  List<Tab> _list = [];
  items.forEach((title, item) {
    _list.add(Tab(text: title));
  });
  return _list;
}

Widget _createTabBarView(String title, Map<String, List<Item>> items) {
  var _list = items[title];
  return Container(
    child: ListView.builder(
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        var item = _list[index];
        return ListTile(
          title: Text(item.getTitle()),
          subtitle: Text(item.getSubTitle()),
          onTap: () {},
        );
      },
    ),
  );
}
