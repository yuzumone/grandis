// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parade.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parade _$ParadeFromJson(Map<String, dynamic> json) => Parade(
      json['FacilityName'] as String,
      json['FacilityStatus'] as String?,
      (json['operatingHours'] as List<dynamic>?)
          ?.map((e) => OperatingHours.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['UpdateTime'] as String?,
    );
