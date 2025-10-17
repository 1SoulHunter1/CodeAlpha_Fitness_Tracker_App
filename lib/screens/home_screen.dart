import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fitness_provider.dart';
import '../widgets/activity_card.dart';
import '../widgets/stat_card.dart'; // We'll reuse the StatCard here
import '../utils/helpers.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<FitnessProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return CustomScrollView(
              slivers: [
                // --- UI REFINEMENT ---
                // The SliverAppBar is redesigned for a cleaner, more modern greeting experience.
                // The greeting is now part of the background, creating a more elegant static header
                // and leaving the collapsed app bar clean.
                SliverAppBar(
                  expandedHeight: 140.0,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  // We remove the pinned property to let the greeting scroll away naturally.
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.all(16.0),
                      // Using a Column provides a more stable layout than the previous Stack/Positioned combo.
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat.yMMMMd().format(DateTime.now()),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color
                                      ?.withOpacity(0.6),
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Hello, User!',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // --- UI REFINEMENT ---
                // Added a dedicated header for the summary section to improve visual hierarchy.
                _buildSectionHeader(context, "Today's Summary"),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: 'Steps Today',
                            value: formatNumber(provider.totalStepsToday),
                            icon: Icons.directions_walk,
                            iconColor: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: 'Workouts Today',
                            value: provider.activities
                                .where(
                                  (a) => a.timestamp.day == DateTime.now().day,
                                )
                                .length
                                .toString(),
                            icon: Icons.fitness_center,
                            iconColor: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                _buildSectionHeader(context, 'Recent Activity'),

                _buildActivityList(provider, context),
              ],
            );
          },
        ),
      ),
    );
  }

  // A new reusable widget for creating styled section headers.
  Widget _buildSectionHeader(BuildContext context, String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }

  // Helper widget to handle both the activity list and the empty state.
  Widget _buildActivityList(FitnessProvider provider, BuildContext context) {
    if (provider.activities.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.note_alt_outlined,
                  size: 80,
                  color: Colors.grey.withOpacity(0.5),
                ),
                const SizedBox(height: 20),
                // --- UI REFINEMENT ---
                // Updated hardcoded TextStyles to use the app's theme for consistency.
                Text(
                  'No activities yet',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Press the "+" button to log your first activity and start your fitness journey!',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final activity = provider.activities[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: ActivityCard(activity: activity),
        );
      }, childCount: provider.activities.length),
    );
  }
}
