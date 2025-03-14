import 'package:json_annotation/json_annotation.dart';

part 'place_response.g.dart';

@JsonSerializable()
class PlacesResponse {
  PlacesResponse({
    this.address,
    this.status,
  });

  @JsonKey(name: "predictions")
  final List<Address>? address;
  final String? status;

  Map<String, dynamic> toJson() => _$PlacesResponseToJson(this);

  factory PlacesResponse.fromJson(Map<String, dynamic> json) =>
      _$PlacesResponseFromJson(json);
}

@JsonSerializable()
class Address {
  Address({
    required this.description,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
    required this.terms,
    required this.types,
  });

  final String description;
  @JsonKey(name: "matched_substrings")
  final List<MatchedSubstring> matchedSubstrings;
  @JsonKey(name: "place_id")
  final String placeId;
  final String reference;
  @JsonKey(name: "structured_formatting")
  final StructuredFormatting structuredFormatting;
  final List<Term> terms;
  final List<String> types;
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@JsonSerializable()
class MatchedSubstring {
  MatchedSubstring({
    required this.length,
    required this.offset,
  });

  final int length;
  final int offset;

  Map<String, dynamic> toJson() => _$MatchedSubstringToJson(this);

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) =>
      _$MatchedSubstringFromJson(json);
}

@JsonSerializable()
class StructuredFormatting {
  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
  });
  @JsonKey(name: "main_text")
  final String mainText;
  @JsonKey(name: "main_text_matched_substrings")
  final List<MatchedSubstring> mainTextMatchedSubstrings;
  @JsonKey(name: "secondary_text")
  final String secondaryText;

  Map<String, dynamic> toJson() => _$StructuredFormattingToJson(this);

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);
}

@JsonSerializable()
class Term {
  Term({
    required this.offset,
    required this.value,
  });

  final int offset;
  final String value;

  Map<String, dynamic> toJson() => _$TermToJson(this);

  factory Term.fromJson(Map<String, dynamic> json) => _$TermFromJson(json);
}
