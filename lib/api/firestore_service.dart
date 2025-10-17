// Note: Ensure you have set up Firebase in your project for this to work.
// 1. Go to https://console.firebase.google.com/
// 2. Create a new project.
// 3. Add a new Flutter app.
// 4. Follow the CLI instructions (flutterfire configure).
// 5. Enable Firestore database in the Firebase console.

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/activity.dart';
import 'database_service.dart';

class FirestoreService implements DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collectionName = 'activities';

  @override
  Future<void> addActivity(Activity activity) async {
    await _db.collection(_collectionName).add(activity.toMap());
  }

  @override
  Future<List<Activity>> getActivities() async {
    QuerySnapshot snapshot = await _db
        .collection(_collectionName)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      return Activity.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  @override
  Future<void> updateActivity(Activity activity) async {
    if (activity.id == null) return;
    await _db
        .collection(_collectionName)
        .doc(activity.id)
        .update(activity.toMap());
  }

  @override
  Future<void> deleteActivity(String id) async {
    await _db.collection(_collectionName).doc(id).delete();
  }
}
