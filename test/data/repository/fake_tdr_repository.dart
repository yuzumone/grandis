import 'package:grandis/data/model/park_type.dart';
import 'package:grandis/data/model/item.dart';
import 'package:grandis/data/repository/tdr_repository.dart';
import 'package:http/src/client.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

class FakeTdrRepository implements TdrRepository {
  @override
  Client get client => MockClient();

  @override
  Future<List<Item>> getAttraction(ParkType type) async {
    return [];
  }

  @override
  Future<List<Item>> getGreeting(ParkType type) async {
    return [];
  }

  @override
  Future<List<Item>> getNewGoods(ParkType type) async {
    return [];
  }

  @override
  Future<List<Item>> getParade(ParkType type) async {
    return [];
  }

  @override
  Future<List<Item>> getRehabilitate(ParkType type) async {
    return [];
  }

  @override
  Future<List<Item>> getRestaurant(ParkType type) async {
    return [];
  }

  @override
  Future<List<Item>> getSoon(ParkType type) async {
    return [];
  }

  @override
  Future<String> getStatus(ParkType type) async {
    return '閉園しています。';
  }
}
