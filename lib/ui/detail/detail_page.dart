import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:grandis/data/model/item.dart';
import 'package:grandis/data/model/park_type.dart';
import 'package:grandis/ui/detail/detail_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({required ParkType this.type, Key? key}) : super(key: key);

  final type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailViewModel = ref.read(detailViewModelProvider);
    final attraction =
        ref.watch(detailViewModelProvider.select((value) => value.attraction));
    final parade =
        ref.watch(detailViewModelProvider.select((value) => value.parade));
    final greeting =
        ref.watch(detailViewModelProvider.select((value) => value.greeting));
    final restaurant =
        ref.watch(detailViewModelProvider.select((value) => value.restaurant));
    final rehabilitate = ref
        .watch(detailViewModelProvider.select((value) => value.rehabilitate));
    final tabs = <String, List<Item>?>{
      'attraction': attraction,
      'parade': parade,
      'greeting': greeting,
      'restaurant': restaurant,
      'rehabilitate': rehabilitate,
    };

    final snapshot = useFuture(useMemoized(
        () => Future.wait([
              detailViewModel.getAttraction(type),
              detailViewModel.getParade(type),
              detailViewModel.getGreeting(type),
              detailViewModel.getRestaurant(type),
              detailViewModel.getRehabilitate(type),
            ]),
        [type]));

    return DefaultTabController(
      length: tabs.keys.length,
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('grandis'),
            backgroundColor: _getColorFromType(type),
            bottom: TabBar(
              tabs: tabs.keys.map((title) => Tab(text: title)).toList(),
              indicatorColor: Colors.white,
              isScrollable: true,
            ),
          ),
          body: TabBarView(
            children: snapshot.connectionState == ConnectionState.waiting
                ? tabs.keys.map((e) => SizedBox()).toList()
                : tabs.values.map((e) => _createTabBarView(e)).toList(),
          ),
        );
      }),
    );
  }

  MaterialColor _getColorFromType(ParkType type) {
    switch (type) {
      case ParkType.TDL:
        return Colors.pink;
      case ParkType.TDS:
        return Colors.blue;
    }
  }

  Widget _createTabBarView(List<Item>? items) {
    if (items == null) return SizedBox();
    return Container(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          var item = items[index];
          return Container(
            margin: const EdgeInsets.only(
                left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.getTitle()),
                SizedBox(height: 4.0),
                Text(item.getSubTitle()),
              ],
            ),
          );
        },
      ),
    );
  }
}
