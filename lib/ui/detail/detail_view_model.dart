import 'package:flutter/material.dart';
import 'package:grandis/data/model/item.dart';
import 'package:grandis/data/model/park_type.dart';
import 'package:grandis/data/repository/tdr_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final detailViewModelProvider =
    ChangeNotifierProvider((ref) => DetailViewModel(ref.read));

class DetailViewModel extends ChangeNotifier {
  DetailViewModel(this._reader);

  final Reader _reader;
  late final TdrRepository _repository = _reader(tdrRepositoryProvider);

  List<Item>? _attraction;
  List<Item>? get attraction => _attraction;
  List<Item>? _parade;
  List<Item>? get parade => _parade;
  List<Item>? _greeting;
  List<Item>? get greeting => _greeting;
  List<Item>? _restaurant;
  List<Item>? get restaurant => _restaurant;
  List<Item>? _rehabilitate;
  List<Item>? get rehabilitate => _rehabilitate;
  List<Item>? _newGoods;
  List<Item>? get newGoods => _newGoods;
  List<Item>? _soonGoods;
  List<Item>? get soonGoods => _soonGoods;

  Future<void> getAttraction(ParkType type) {
    return _repository
        .getAttraction(type)
        .then((value) => _attraction = value)
        .whenComplete(notifyListeners);
  }

  Future<void> getParade(ParkType type) {
    return _repository
        .getParade(type)
        .then((value) => _parade = value)
        .whenComplete(notifyListeners);
  }

  Future<void> getGreeting(ParkType type) {
    return _repository
        .getGreeting(type)
        .then((value) => _greeting = value)
        .whenComplete(notifyListeners);
  }

  Future<void> getRestaurant(ParkType type) {
    return _repository
        .getRestaurant(type)
        .then((value) => _restaurant = value)
        .whenComplete(notifyListeners);
  }

  Future<void> getRehabilitate(ParkType type) {
    return _repository
        .getRehabilitate(type)
        .then((value) => _rehabilitate = value)
        .whenComplete(notifyListeners);
  }

  Future<void> getNewGoods(ParkType type) {
    return _repository
        .getNewGoods(type)
        .then((value) => _newGoods = value)
        .whenComplete(notifyListeners);
  }

  Future<void> getSoon(ParkType type) {
    return _repository
        .getSoon(type)
        .then((value) => _soonGoods = value)
        .whenComplete(notifyListeners);
  }
}
