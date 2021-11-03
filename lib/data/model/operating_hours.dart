import 'package:json_annotation/json_annotation.dart';

part 'operating_hours.g.dart';

@JsonSerializable(createToJson: false)
class OperatingHours {
  @JsonKey(name: 'OperatingHoursFrom')
  final String? operatingHoursFrom;
  @JsonKey(name: 'OperatingHoursTo')
  final String? operatingHoursTo;
  @JsonKey(name: 'OperatingStatus')
  final String? operatingStatus;

  OperatingHours(
    this.operatingHoursFrom,
    this.operatingHoursTo,
    this.operatingStatus,
  );

  factory OperatingHours.fromJson(Map<String, dynamic> json) =>
      _$OperatingHoursFromJson(json);
}
