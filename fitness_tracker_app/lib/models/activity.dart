class Activity {
  final int? id;
  final String type;
  final int duration;
  final double? distance;
  final int calories;
  final DateTime createdAt;
  final String syncId;

  Activity({
    this.id,
    required this.type,
    required this.duration,
    this.distance,
    required this.calories,
    required this.createdAt,
    required this.syncId,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      type: json['type'],
      duration: json['duration'],
      distance: json['distance'],
      calories: json['calories'],
      createdAt: DateTime.parse(json['created_at']),
      syncId: json['sync_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'duration': duration,
      'distance': distance,
      'calories': calories,
      'created_at': createdAt.toIso8601String(),
      'sync_id': syncId,
    };
  }
}