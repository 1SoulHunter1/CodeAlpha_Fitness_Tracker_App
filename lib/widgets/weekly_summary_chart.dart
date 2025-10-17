import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklySummaryChart extends StatelessWidget {
  final Map<String, double> summaryData;

  const WeeklySummaryChart({super.key, required this.summaryData});

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    // Find the maximum value for the Y-axis, handle empty data
    final double maxYValue = summaryData.values.isEmpty
        ? 100 // A default value if no data exists
        : summaryData.values.reduce((a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: (maxYValue * 1.2).ceilToDouble(), // Add 20% buffer and round up
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            // --- FIX IS HERE ---
            // The 'tooltipColor' property was replaced with a callback function 'getTooltipColor'.
            getTooltipColor: (barChartGroupData) => Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.round()} kcal',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const titles = [
                  'Mon',
                  'Tue',
                  'Wed',
                  'Thu',
                  'Fri',
                  'Sat',
                  'Sun',
                ];
                // Defensive check to prevent range errors
                if (value.toInt() >= 0 && value.toInt() < titles.length) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 4.0,
                    child: Text(
                      titles[value.toInt()],
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
              reservedSize: 28,
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: summaryData.entries.map((entry) {
          const dayMapping = {
            'Mon': 0,
            'Tue': 1,
            'Wed': 2,
            'Thu': 3,
            'Fri': 4,
            'Sat': 5,
            'Sun': 6,
          };
          int index = dayMapping[entry.key] ?? 0;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: entry.value,
                color: primaryColor,
                width: 16,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
