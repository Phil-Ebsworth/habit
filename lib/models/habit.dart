class Habit {
  final String id;
  final String name;
  final DateTime startDate;
  final List<bool> completionStatus;
  final bool isPositive; // Neues Feld für positive oder negative Gewohnheiten
  int relapseCount;

  Habit({
    required this.id,
    required this.name,
    required this.startDate,
    required this.completionStatus,
    required this.isPositive, // Muss jetzt beim Erstellen angegeben werden
    this.relapseCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'startDate': startDate.toIso8601String(),
      'completionStatus': completionStatus.map((e) => e ? 1 : 0).toList(),
      'isPositive': isPositive, // Speichert, ob die Gewohnheit positiv ist
      'relapseCount': relapseCount,
    };
  }

  static Habit fromMap(String id, Map<String, dynamic> map) {
    return Habit(
      id: id,
      name: map['name'],
      startDate: DateTime.parse(map['startDate']),
      completionStatus: List<bool>.from(
          map['completionStatus'].map((e) => e == 1 ? true : false)),
      isPositive:
          map['isPositive'] ?? true, // Standardmäßig positive Gewohnheit
      relapseCount: map['relapseCount'] ?? 0,
    );
  }
}
