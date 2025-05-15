import 'package:json_annotation/json_annotation.dart';

part 'empty_data.g.dart';

@JsonSerializable()
class Emptydata {
  final bool? success;
  final String? message;
  final int? code;
  final String? returnStatus;
  final Data? data;

  const Emptydata({
    this.success,
    this.message,
    this.code,
    this.returnStatus,
    this.data,
  });

  factory Emptydata.fromJson(Map<String, dynamic> json) =>
      _$EmptydataFromJson(json);

  Map<String, dynamic> toJson() => _$EmptydataToJson(this);
}

@JsonSerializable()
class Data {
  const Data();

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
