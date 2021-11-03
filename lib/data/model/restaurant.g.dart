// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      json['FacilityName'] as String,
      json['FacilityStatus'] as String?,
      Restaurant._dynamicToString(json['StandbyTimeMin']),
      Restaurant._dynamicToString(json['StandbyTimeMax']),
      (json['operatingHours'] as List<dynamic>?)
          ?.map((e) => OperatingHours.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['UpdateTime'] as String?,
      json['PopCornFlavors'] as String?,
    );
