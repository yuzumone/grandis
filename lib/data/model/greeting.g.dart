// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'greeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Greeting _$GreetingFromJson(Map<String, dynamic> json) => Greeting(
      json['FacilityName'] as String,
      json['AreaJName'] as String?,
      json['FacilityStatus'] as String?,
      json['StandbyTime'] as String?,
      (json['operatinghours'] as List<dynamic>?)
          ?.map((e) => OperatingHours.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['UpdateTime'] as String?,
    );
