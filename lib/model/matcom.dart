
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'matcom.g.dart';

@JsonSerializable()
class Matcom extends Equatable{
  final String name;
  final String url;
  final String snippet;
  Matcom({this.name, this.snippet, this.url});
  @override
  List<Object> get props => [name,url,snippet];

  factory Matcom.fromJson(Map<String,dynamic> json) => _$MatcomFromJson(json);

  Map<String,dynamic> toJson() => _$MatcomToJson(this);

}