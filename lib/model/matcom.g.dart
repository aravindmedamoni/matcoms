// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matcom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Matcom _$MatcomFromJson(Map<String, dynamic> json) {
  return Matcom(
    name: json['name'] as String,
    snippet: json['snippet'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$MatcomToJson(Matcom instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'snippet': instance.snippet,
    };
