/// CColor Model definition
class CColor {
  /// Create color object
  CColor({
    required this.color,
    this.clientID = '0',
  });

  /// From Json constructor
  factory CColor.fromJson(Map<String, String> color) {
    return CColor(color: color['color']!, clientID: color['clientID']!);
  }

  /// Color
  final String color;

  /// Client ID
  final String clientID;

  /// Get JSON object
  Map<String, String> toJson() {
    return <String, String>{
      'color': color,
      'clientID': clientID,
    };
  }
}
