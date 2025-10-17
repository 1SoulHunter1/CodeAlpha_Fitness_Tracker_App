import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fitness_provider.dart';
import '../widgets/chart_container.dart';
import '../widgets/stat_card.dart';
import '../widgets/weekly_summary_chart.dart';
import '../utils/helpers.dart';
import '../widgets/circular_progress_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SafeArea(
        child: Consumer<FitnessProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // --- FIX IS HERE ---
            // Added a check to handle the case where no activities have been logged.
            // This prevents child widgets from receiving empty or zero data,
            // which can cause null errors, and provides a better user experience.
            if (provider.activities.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.analytics_outlined,
                        size: 80,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.7),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'No Activity Data',
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Log your first activity using the "+" button to see your dashboard stats here.',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            final weeklySummary = provider.weeklySummary;
            final totalSteps = provider.totalStepsToday;
            const int stepGoal = 10000;
            final double stepProgress = (totalSteps / stepGoal).clamp(0.0, 1.0);

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressCard(
                      title: "Today's Steps",
                      currentValue: formatNumber(totalSteps),
                      goalValue: formatNumber(stepGoal),
                      progress: stepProgress,
                      progressColor: Theme.of(
                        context,
                      ).colorScheme.secondary, // Blue for activity
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: ChartContainer(
                      title: 'Weekly Calories Summary',
                      chart: WeeklySummaryChart(summaryData: weeklySummary),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Total Calories (Week)',
                            value: formatNumber(
                              weeklySummary.values.fold(
                                0,
                                (a, b) => a + b.toInt(),
                              ),
                            ),
                            icon: Icons.local_fire_department,
                            iconColor: Colors.redAccent,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: 'Workouts (Week)',
                            value: provider.activities.length
                                .toString(), // Example stat
                            icon: Icons.fitness_center,
                            iconColor: Colors.purpleAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
