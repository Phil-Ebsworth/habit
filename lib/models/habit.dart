class Habit {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime relapseDate;
  final List<bool> completionStatus;
  final DateTime completionDate;
  final bool isPositive;
  int relapseCount;

  Habit({
    required this.id,
    required this.name,
    required this.startDate,
    required this.completionStatus,
    required this.isPositive,
    required this.relapseDate,
    required this.completionDate,
    this.relapseCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'startDate': startDate.toIso8601String(),
      'completionStatus': completionStatus.map((e) => e ? 1 : 0).toList(),
      'completionDate': completionDate.toIso8601String(),
      'isPositive': isPositive,
      'relapseCount': relapseCount,
      'relapseDate': relapseDate.toIso8601String(),
    };
  }

  static Habit fromMap(String id, Map<String, dynamic> map) {
    return Habit(
      id: id,
      name: map['name'],
      startDate: DateTime.parse(map['startDate']),
      completionStatus: List<bool>.from(
          map['completionStatus'].map((e) => e == 1 ? true : false)),
      completionDate: DateTime.parse(map['completionDate']),
      isPositive:
          map['isPositive'] ?? true, // Standardmäßig positive Gewohnheit
      relapseCount: map['relapseCount'] ?? 0,
      relapseDate: DateTime.parse(map['relapseDate']),
    );
  }

  Habit copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    List<bool>? completionStatus,
    bool? isPositive,
    DateTime? relapseDate,
    DateTime? completionDate,
    int? relapseCount,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      completionStatus: completionStatus ?? this.completionStatus,
      isPositive: isPositive ?? this.isPositive,
      relapseDate: relapseDate ?? this.relapseDate,
      completionDate: completionDate ?? this.completionDate,
      relapseCount: relapseCount ?? this.relapseCount,
    );
  }
}
