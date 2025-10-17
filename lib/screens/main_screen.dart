import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'add_log_screen.dart';
import 'dashboard_screen.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // --- PERFORMANCE OPTIMIZATION ---
  // The list of pages is now final instead of const to allow for hot reloads
  // and potential future state passing, but it's still created only once.
  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const DashboardScreen(),
    const StatsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- PERFORMANCE OPTIMIZATION ---
      // Replaced AnimatedSwitcher with IndexedStack.
      // IndexedStack is highly performant for bottom navigation as it keeps all
      // pages in the widget tree but only paints the active one.
      // This results in instant screen switching and preserves the state of each page.
      body: IndexedStack(index: _selectedIndex, children: _pages),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddLogScreen()),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home_outlined),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: const Icon(Icons.dashboard_outlined),
              onPressed: () => _onItemTapped(1),
            ),
            const SizedBox(width: 48), // The space for the FAB
            IconButton(
              icon: const Icon(Icons.bar_chart_outlined),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
