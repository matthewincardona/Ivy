import 'dart:convert';

class Data {
  final List<String> words;
  Data({
    required this.words,
  });

  Data copyWith({
    List<String>? words,
  }) {
    return Data(
      words: words ?? this.words,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'words': words,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      words:
          List<String>.from(map['words'] ?? []), // Provide a default empty list
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(words: $words)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data && other.words == words;
  }

  @override
  int get hashCode => words.hashCode;
}
