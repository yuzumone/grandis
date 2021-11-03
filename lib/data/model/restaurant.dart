import 'package:grandis/data/model/item.dart';
import 'package:grandis/data/model/operating_hours.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable(createToJson: false)
class Restaurant implements Item {
  @JsonKey(name: 'FacilityName')
  final String name;
  @JsonKey(name: 'FacilityStatus')
  final String? status;
  @JsonKey(name: 'StandbyTimeMin', fromJson: _dynamicToString)
  final String standbyTimeMin;
  @JsonKey(name: 'StandbyTimeMax', fromJson: _dynamicToString)
  final String standbyTimeMax;
  @JsonKey(name: 'operatingHours')
  final List<OperatingHours>? operatingHours;
  @JsonKey(name: 'UpdateTime')
  final String? updateTime;
  @JsonKey(name: 'PopCornFlavors')
  final String? popCornFlavors;

  Restaurant(
    this.name,
    this.status,
    this.standbyTimeMin,
    this.standbyTimeMax,
    this.operatingHours,
    this.updateTime,
    this.popCornFlavors,
  );

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

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
    String? wait;
    if (standbyTimeMin == 'null' && standbyTimeMax == 'null') {
      wait = null;
    } else if (standbyTimeMax == 'null') {
      wait = '$standbyTimeMin分以上';
    } else if (standbyTimeMin == standbyTimeMax) {
      wait = '$standbyTimeMax分';
    } else {
      wait = '$standbyTimeMin - $standbyTimeMax分';
    }
    if (wait != null) {
      str.add('待ち時間: $wait');
    }
    if (operatingHours != null) {
      operatingHours!.forEach((hour) {
        var sta = hour.operatingStatus;
        sta ??= '';
        str.add('${hour.operatingHoursFrom} - ${hour.operatingHoursTo}\t$sta');
      });
    }
    if (popCornFlavors != null) {
      str.add(popCornFlavors!);
    }
    str.add('更新時間: $updateTime');
    return str.join('\n');
  }

  @override
  String toString() {
    return 'name: $name, status: $status, min: $standbyTimeMin, max: $standbyTimeMax, operating: $operatingHours, update: $updateTime';
  }

  static String _dynamicToString(dynamic string) => string.toString();
}
