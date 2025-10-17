import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../api/database_service.dart';
import '../api/sqlite_service.dart';
// import '../api/firestore_service.dart'; // Uncomment to use Firebase

class FitnessProvider with ChangeNotifier {
  final DatabaseService _dbService = SqliteService();

  List<Activity> _activities = [];
  bool _isLoading = false;

  List<Activity> get activities => _activities;
  bool get isLoading => _isLoading;

  FitnessProvider() {
    loadActivities();
  }

  Future<void> loadActivities() async {
    _isLoading = true;
    notifyListeners();
    _activities = await _dbService.getActivities();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addActivity(Activity activity) async {
    await _dbService.addActivity(activity);
    await loadActivities();
  }

  // --- NEW METHOD ---
  // This is the missing method. It takes an activity and passes it
  // to the database service to be updated.
  Future<void> updateActivity(Activity activity) async {
    await _dbService.updateActivity(activity);
    await loadActivities(); // Refresh the list after updating
  }

  Future<void> deleteActivity(String id) async {
    await _dbService.deleteActivity(id);
    await loadActivities();
  }

  Map<String, double> get weeklySummary {
    Map<String, double> summary = {
      'Mon': 0,
      'Tue': 0,
      'Wed': 0,
      'Thu': 0,
      'Fri': 0,
      'Sat': 0,
      'Sun': 0,
    };
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    for (var activity in _activities) {
      if (activity.timestamp.isAfter(startOfWeek)) {
        String day = _getDayOfWeek(activity.timestamp.weekday);
        summary[day] = (summary[day] ?? 0) + activity.calories;
      }
    }
    return summary;
  }

  String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  int get totalStepsToday {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    int total = 0;
    for (var act in _activities.where((a) => a.timestamp.isAfter(today))) {
      total += act.steps;
    }
    return total;
  }
}
