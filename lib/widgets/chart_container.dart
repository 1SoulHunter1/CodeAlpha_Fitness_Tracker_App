import 'package:flutter/material.dart';

// A styled container to wrap our charts, providing a consistent look.
class ChartContainer extends StatelessWidget {
  final String title;
  final Widget chart;

  const ChartContainer({super.key, required this.title, required this.chart});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 20),
            SizedBox(height: 200, child: chart),
          ],
        ),
      ),
    );
  }
}
