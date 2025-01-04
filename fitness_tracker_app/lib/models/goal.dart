class Goal {
  final int? id;
  final String type;
  final double target;
  final DateTime startDate;
  final DateTime endDate;
  final bool completed;

  Goal({
    this.id,
    required this.type,
    required this.target,
    required this.startDate,
    required this.endDate,
    this.completed = false,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'],
      type: json['type'],
      target: json['target'].toDouble(),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'target': target,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'completed': completed,
    };
  }
}