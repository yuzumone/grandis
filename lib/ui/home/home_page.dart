import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:grandis/data/model/park_type.dart';
import 'package:grandis/ui/detail/detail_page.dart';
import 'package:grandis/ui/home/home_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.read(homeViewModelProvider);
    final tdlStatus =
        ref.watch(homeViewModelProvider.select((value) => value.tdlStatus));
    final tdsStatus =
        ref.watch(homeViewModelProvider.select((value) => value.tdsStatus));

    final snapshot = useFuture(useMemoized(
      () => Future.wait([
        homeViewModel.getTdlStatus(),
        homeViewModel.getTdsStatus(),
      ]),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('grandis'),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DetailPage(type: ParkType.TDL)),
                      );
                    },
                    child: const Text(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DetailPage(type: ParkType.TDS)),
                      );
                    },
                    child: const Text(
                      'ディズニーシー',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: snapshot.connectionState == ConnectionState.waiting ||
                    tdlStatus == null ||
                    tdsStatus == null
                ? SizedBox()
                : Flexible(
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
                            Text(tdlStatus),
                            SizedBox(height: 8.0),
                            Text(tdsStatus),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
