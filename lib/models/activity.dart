import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  final String? id;
  final String type;
  final int duration; // in minutes
  final int calories;
  final int steps;
  final DateTime timestamp;

  Activity({
    this.id,
    required this.type,
    required this.duration,
    required this.calories,
    required this.steps,
    required this.timestamp,
  });

  // Factory constructor to create an Activity from a map (e.g., from Firestore)
  factory Activity.fromMap(Map<String, dynamic> data, String documentId) {
    return Activity(
      id: documentId,
      type: data['type'] ?? '',
      duration: data['duration'] ?? 0,
      calories: data['calories'] ?? 0,
      steps: data['steps'] ?? 0,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  // Factory constructor to create an Activity from a local DB map
  factory Activity.fromDbMap(Map<String, dynamic> data) {
    return Activity(
      id: data['id'].toString(),
      type: data['type'] ?? '',
      duration: data['duration'] ?? 0,
      calories: data['calories'] ?? 0,
      steps: data['steps'] ?? 0,
      timestamp: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
    );
  }

  // Method to convert an Activity instance to a map (for writing to Firestore/SQLite)
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'duration': duration,
      'calories': calories,
      'steps': steps,
      'timestamp': Timestamp.fromDate(
        timestamp,
      ), // Correctly convert DateTime to Timestamp
    };
  }

  Map<String, dynamic> toDbMap() {
    return {
      'type': type,
      'duration': duration,
      'calories': calories,
      'steps': steps,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}
