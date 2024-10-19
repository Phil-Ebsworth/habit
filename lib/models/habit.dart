class Habit {
  final String id; // Firestore benötigt eine ID
  final String name;
  final DateTime startDate;
  List<bool> completionStatus;

  Habit({
    required this.id,
    required this.name,
    required this.startDate,
    required this.completionStatus,
  });

  // Firestore speichert Daten als Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'startDate': startDate.toIso8601String(),
      'completionStatus': completionStatus.map((e) => e ? 1 : 0).toList(),
    };
  }

  // Erstellt ein Habit-Objekt aus einem Firestore-Dokument
  static Habit fromMap(String id, Map<String, dynamic> map) {
    return Habit(
      id: id,
      name: map['name'],
      startDate: DateTime.parse(map['startDate']),
      completionStatus: List<bool>.from(
          map['completionStatus'].map((e) => e == 1 ? true : false)),
    );
  }
}
