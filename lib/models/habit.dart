class Habit {
  final String id;
  final String name;
  final DateTime startDate;
  final List<bool> completionStatus;
  int relapseCount; // Neues Feld für die Anzahl der Rückfälle

  Habit({
    required this.id,
    required this.name,
    required this.startDate,
    required this.completionStatus,
    this.relapseCount = 0, // Standardmäßig 0 Rückfälle
  });

  // Firestore speichert Daten als Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'startDate': startDate.toIso8601String(),
      'completionStatus': completionStatus.map((e) => e ? 1 : 0).toList(),
      'relapseCount': relapseCount, // Rückfälle speichern
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
      relapseCount:
          map['relapseCount'] ?? 0, // Standardmäßig 0, falls nicht vorhanden
    );
  }
}
