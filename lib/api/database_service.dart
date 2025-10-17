import '../models/activity.dart';

abstract class DatabaseService {
  Future<void> addActivity(Activity activity);
  Future<List<Activity>> getActivities();
  // --- NEW LINE ---
  // Adds the requirement for an update method to any database implementation.
  Future<void> updateActivity(Activity activity);
  Future<void> deleteActivity(String id);
}
