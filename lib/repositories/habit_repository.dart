import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/habit.dart';

class HabitRepository {
  final CollectionReference habitsCollection =
      FirebaseFirestore.instance.collection('habits');

  // Habit hinzufügen
  Future<void> addHabit(Habit habit) async {
    await habitsCollection.add(habit.toMap());
  }

  // Alle Habits laden
  Future<List<Habit>> getHabits() async {
    QuerySnapshot snapshot = await habitsCollection.get();
    return snapshot.docs
        .map((doc) => Habit.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
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
