import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // New import
import '../providers/theme_provider.dart'; // New import

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the ThemeProvider.
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: const Text('Your Name'),
                subtitle: const Text('Edit your profile'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text('Dark Mode'),
                subtitle: const Text('Toggle between light and dark themes'),
                trailing: Switch(
                  // The switch value is now driven by the provider's state.
                  value: themeProvider.themeMode == ThemeMode.dark,
                  // The onChanged callback now calls the provider's method.
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.track_changes),
                title: const Text('Set Your Goals'),
                subtitle: const Text('Daily steps, calories, etc.'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
