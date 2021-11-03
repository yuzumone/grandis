import 'package:grandis/data/model/item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attraction.g.dart';

@JsonSerializable(createToJson: false)
class Attraction implements Item {
  @JsonKey(name: 'FacilityName')
  final String name;
  @JsonKey(name: 'StandbyTime', fromJson: _dynamicToString)
  final String standbyTime;
  @JsonKey(name: 'OperatingStatus')
  final String? status;
  @JsonKey(name: 'UpdateTime')
  final String? updateTime;
  @JsonKey(name: 'FsStatus')
  final String? fsStatus;

  Attraction(
    this.name,
    this.standbyTime,
    this.status,
    this.updateTime,
    this.fsStatus,
  );

  factory Attraction.fromJson(Map<String, dynamic> json) =>
      _$AttractionFromJson(json);

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    var str = <String>[];
    if (standbyTime != 'false' && standbyTime != 'null') {
      str.add('待ち時間: $standbyTime分');
    }
    if (fsStatus != null) {
      str.add('FP: $fsStatus');
    }
    if (status != null) {
      str.add(status!);
    }
    str.add('更新時間: $updateTime');
    return str.join('\n');
  }

  @override
  String toString() {
    return 'name: $name, standbyTime: $standbyTime, status: $status, update: $updateTime';
  }

  static String _dynamicToString(dynamic string) => string.toString();
}
