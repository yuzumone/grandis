import 'package:flutter/material.dart';
import 'package:grandis/data/model/park_type.dart';
import 'package:grandis/data/repository/tdr_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModelProvider =
    ChangeNotifierProvider((ref) => HomeViewModel(ref.read));

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._reader);

  final Reader _reader;
  late final TdrRepository _repository = _reader(tdrRepositoryProvider);

  String? _tdlStatus;
  String? get tdlStatus => _tdlStatus;
  String? _tdsStatus;
  String? get tdsStatus => _tdsStatus;

  Future<void> getTdlStatus() {
    return _repository
        .getStatus(ParkType.TDL)
        .then((value) => _tdlStatus = value)
        .whenComplete(notifyListeners);
  }

  Future<void> getTdsStatus() {
    return _repository
        .getStatus(ParkType.TDS)
        .then((value) => _tdsStatus = value)
        .whenComplete(notifyListeners);
  }
}
