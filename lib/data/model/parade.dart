import 'package:grandis/data/model/item.dart';
import 'package:grandis/data/model/operating_hours.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parade.g.dart';

@JsonSerializable(createToJson: false)
class Parade implements Item {
  @JsonKey(name: 'FacilityName')
  final String name;
  @JsonKey(name: 'FacilityStatus')
  final String? status;
  @JsonKey(name: 'operatingHours')
  final List<OperatingHours>? operatingHours;
  @JsonKey(name: 'UpdateTime')
  final String? updateTime;

  Parade(this.name, this.status, this.operatingHours, this.updateTime);

  factory Parade.fromJson(Map<String, dynamic> json) => _$ParadeFromJson(json);

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
    if (operatingHours != null) {
      for (var hour in operatingHours ?? []) {
        str.add('${hour.operatingHoursFrom} - ');
      }
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
    return 'name: $name, status: $status, operating: $operatingHours, update: $updateTime';
  }
}
