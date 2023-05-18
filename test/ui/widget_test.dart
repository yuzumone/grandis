import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grandis/app.dart';
import 'package:grandis/ui/home/home_page.dart';
import 'package:grandis/ui/home/home_view_model.dart';
import 'package:grandis/ui/route/app_router.dart';
import 'package:grandis/ui/route/app_router.gr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeViewModel extends Mock implements HomeViewModel {}

void main() {
  final mockHomeViewModel = MockHomeViewModel();
  when(mockHomeViewModel.getTdlStatus).thenAnswer((_) => Future.value());
  when(() => mockHomeViewModel.tdlStatus).thenReturn('閉園しています。');
  when(mockHomeViewModel.getTdsStatus).thenAnswer((_) => Future.value());
  when(() => mockHomeViewModel.tdlStatus).thenReturn('閉園しています。');

  testWidgets('App widget test', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homeViewModelProvider.overrideWith((ref) => mockHomeViewModel),
        ],
        child: const App(),
      ),
    );
  });

  testWidgets('HomePage widget test', (tester) async {
    final appRouter = AppRouter();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homeViewModelProvider.overrideWith((ref) => mockHomeViewModel),
        ],
        child: MaterialApp.router(
          routeInformationParser: appRouter.defaultRouteParser(),
          routerDelegate: appRouter.delegate(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(appRouter.current.name == HomeRoute.name, true);
    expect(find.byType(HomePage), findsOneWidget);
  });
}
