import 'package:flutter_test/flutter_test.dart';
import 'package:grandis/data/repository/tdr_repository.dart';
import 'package:grandis/ui/home/home_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';

import '../data/repository/fake_tdr_repository.dart';

class MockTdrRepository extends Mock implements TdrRepository {}

void main() {
  test('HomeViewModel Test', () async {
    final container = ProviderContainer(
      overrides: [
        tdrRepositoryProvider.overrideWithValue(FakeTdrRepository()),
      ],
    );
    final viewModel = container.read(homeViewModelProvider);
    await expectLater(viewModel.getTdlStatus(), completion('閉園しています。'));
  });
}
