import 'package:grandis/data/model/item.dart';
import 'package:grandis/data/model/operating_hours.dart';
import 'package:json_annotation/json_annotation.dart';

part 'greeting.g.dart';

@JsonSerializable(createToJson: false)
class Greeting implements Item {
  @JsonKey(name: 'FacilityName')
  final String name;
  @JsonKey(name: 'AreaJName')
  final String? area;
  @JsonKey(name: 'FacilityStatus')
  final String? status;
  @JsonKey(name: 'StandbyTime')
  final String? standbyTime;
  @JsonKey(name: 'operatinghours')
  final List<OperatingHours>? operatingHours;
  @JsonKey(name: 'UpdateTime')
  final String? updateTime;

  Greeting(
    this.name,
    this.area,
    this.status,
    this.standbyTime,
    this.operatingHours,
    this.updateTime,
  );

  factory Greeting.fromJson(Map<String, dynamic> json) =>
      _$GreetingFromJson(json);

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    var str = <String>[];
    if (status != null) {
      str.add(status!);
    }
    if (standbyTime != null) {
      str.add('待ち時間: $standbyTime分');
    }
    if (operatingHours != null) {
      operatingHours!.forEach((hour) {
        var sta = hour.operatingStatus;
        sta ??= '';
        str.add('${hour.operatingHoursFrom} - ${hour.operatingHoursTo}\t$sta');
      });
    }
    str.add('更新時間: $updateTime');
    return str.join('\n');
  }

  @override
  String getImage() {
    return '';
  }

  @override
  String getUrl() {
    return '';
  }

  @override
  String toString() {
    return 'name: $name, area: $area, status: $status, standby: $standbyTime, operating: $operatingHours, update: $updateTime';
  }
}
