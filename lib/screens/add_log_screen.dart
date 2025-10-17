import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/activity.dart';
import '../providers/fitness_provider.dart';

class AddLogScreen extends StatefulWidget {
  final Activity? activityToEdit;

  const AddLogScreen({super.key, this.activityToEdit});

  @override
  State<AddLogScreen> createState() => _AddLogScreenState();
}

class _AddLogScreenState extends State<AddLogScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _activityType;
  late final TextEditingController _durationController;
  late final TextEditingController _caloriesController;
  late final TextEditingController _stepsController;
  late bool _isEditMode;

  // A map to associate activity types with icons for the new UI selector.
  final Map<String, IconData> _activityTypes = {
    'Running': Icons.directions_run,
    'Walking': Icons.directions_walk,
    'Cycling': Icons.directions_bike,
    'Swimming': Icons.pool,
    'Workout': Icons.fitness_center,
  };

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.activityToEdit != null;
    final activity = widget.activityToEdit;

    _activityType = activity?.type ?? 'Running';
    _durationController = TextEditingController(
      text: activity?.duration.toString() ?? '',
    );
    _caloriesController = TextEditingController(
      text: activity?.calories.toString() ?? '',
    );
    _stepsController = TextEditingController(
      text: activity?.steps.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _durationController.dispose();
    _caloriesController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<FitnessProvider>(context, listen: false);
      if (_isEditMode) {
        final updatedActivity = Activity(
          id: widget.activityToEdit!.id,
          type: _activityType,
          duration: int.parse(_durationController.text),
          calories: int.parse(_caloriesController.text),
          steps: _stepsController.text.isNotEmpty
              ? int.parse(_stepsController.text)
              : 0,
          timestamp: widget.activityToEdit!.timestamp,
        );
        provider.updateActivity(updatedActivity);
      } else {
        final newActivity = Activity(
          type: _activityType,
          duration: int.parse(_durationController.text),
          calories: int.parse(_caloriesController.text),
          steps: _stepsController.text.isNotEmpty
              ? int.parse(_stepsController.text)
              : 0,
          timestamp: DateTime.now(),
        );
        provider.addActivity(newActivity);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditMode ? 'Edit Log' : 'Add New Log')),
      body: Form(
        key: _formKey,
        child: ListView(
          // --- PERFORMANCE OPTIMIZATION ---
          // Using 'const' for EdgeInsets, as it never changes.
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSectionHeader(context, 'Activity Type'),
            _buildActivityTypeSelector(),
            const SizedBox(height: 24),

            _buildSectionHeader(context, 'Activity Details'),
            _buildTextFormField(
              controller: _durationController,
              labelText: 'Duration',
              suffixText: 'minutes',
              icon: Icons.timer_outlined,
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              controller: _caloriesController,
              labelText: 'Calories Burned',
              suffixText: 'kcal',
              icon: Icons.local_fire_department_outlined,
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              controller: _stepsController,
              labelText: 'Steps (Optional)',
              suffixText: 'steps',
              icon: Icons.directions_walk_outlined,
              isOptional: true,
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                // --- PERFORMANCE OPTIMIZATION ---
                // Using 'const' for the shape, as it's a compile-time constant.
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: Text(
                _isEditMode ? 'Update Log' : 'Save Log',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      // --- PERFORMANCE OPTIMIZATION ---
      // Using 'const' for EdgeInsets.
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }

  Widget _buildActivityTypeSelector() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _activityTypes.entries.map((entry) {
          final isSelected = _activityType == entry.key;
          return GestureDetector(
            onTap: () => setState(() => _activityType = entry.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              // --- PERFORMANCE OPTIMIZATION ---
              // Using a standard Material Design curve for a more natural and responsive feel.
              curve: Curves.fastOutSlowIn,
              margin: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 8.0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    entry.value,
                    size: 32,
                    color: isSelected
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.key,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    String? suffixText,
    bool isOptional = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        suffixText: suffixText,
        // --- PERFORMANCE OPTIMIZATION ---
        // Using 'const' for the border and its radius.
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (!isOptional) {
          if (value == null ||
              value.isEmpty ||
              int.tryParse(value) == null ||
              int.parse(value) <= 0) {
            return 'Please enter a valid positive number';
          }
        } else {
          if (value != null &&
              value.isNotEmpty &&
              (int.tryParse(value) == null || int.parse(value) < 0)) {
            return 'Please enter a valid number';
          }
        }
        return null;
      },
    );
  }
}
