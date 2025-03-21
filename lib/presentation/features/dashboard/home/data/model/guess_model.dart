class Guess {
  final String code;
  final int deadCount;   
  final int injuredCount; 
  
  Guess({
    required this.code,
    required this.deadCount,
    required this.injuredCount,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'deadCount': deadCount,
      'injuredCount': injuredCount,
    };
  }
  
  factory Guess.fromJson(Map<String, dynamic> json) {
    return Guess(
      code: json['code'] as String,
      deadCount: json['deadCount'] as int,
      injuredCount: json['injuredCount'] as int,
    );
  }
}