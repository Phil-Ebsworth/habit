import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/habit.dart';

class HabitRepository {
  final CollectionReference habitsCollection =
      FirebaseFirestore.instance.collection('habits');

  // Stream für Echtzeit-Updates der Habits aus Firestore
  Stream<List<Habit>> habitsStream() {
    return habitsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Habit.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Habit hinzufügen
  Future<void> addHabit(Habit habit) async {
    await habitsCollection.add(habit.toMap());
  }

  // Habit aktualisieren
  Future<void> updateHabit(Habit habit) async {
    await habitsCollection.doc(habit.id).update(habit.toMap());
  }

  // Habit löschen
  Future<void> deleteHabit(String id) async {
    await habitsCollection.doc(id).delete();
  }
}
