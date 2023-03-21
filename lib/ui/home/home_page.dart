import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:grandis/data/model/park_type.dart';
import 'package:grandis/ui/home/home_view_model.dart';
import 'package:grandis/ui/route/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = AutoRouter.of(context);
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
        actions: [
          PopupMenuButton(
            onSelected: (_) {
              PackageInfo.fromPlatform().then((value) => showAboutDialog(
                    context: context,
                    applicationName: value.appName,
                    applicationVersion: value.version,
                    applicationLegalese: 'yuzumone',
                  ));
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 0,
                child: Text('License'),
              ),
            ],
          ),
        ],
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
                      backgroundColor: Colors.pink,
                    ),
                    onPressed: () {
                      router.push(DetailRoute(type: ParkType.TDL));
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
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      router.push(DetailRoute(type: ParkType.TDS));
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
                              child: Text('TDL'),
                            ),
                            Text(tdlStatus),
                            SizedBox(height: 8.0),
                            DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              child: Text('TDS'),
                            ),
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
