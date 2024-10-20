import 'package:drift/drift.dart';
import 'package:flexify/database/database.dart';

const defaultExercises = [
  ('Arnold press', 'Shoulders')
];

const defaultPlans = [
  PlansCompanion(
    id: Value(1),
    days: Value('Monday'),
    exercises: Value(
      'Arnold press',
    ),
  )
];

final defaultPlanExercises = defaultPlans
    .map((plan) {
      final exercises = plan.exercises.value.split(',');
      return defaultExercises.map(
        (exercise) => PlanExercisesCompanion.insert(
          planId: plan.id.value,
          exercise: exercise.$1,
          enabled: exercises.contains(exercise.$1),
          timers: const Value(true),
        ),
      );
    })
    .toList()
    .expand(
      (element) => element,
    );

final defaultSets = defaultExercises.map(
  (exercise) => GymSetsCompanion(
    created: Value(DateTime.now().toLocal()),
    name: Value(exercise.$1),
    reps: const Value(0),
    weight: const Value(0),
    hidden: const Value(true),
    unit: const Value('kg'),
    category: Value(exercise.$2),
  ),
);
