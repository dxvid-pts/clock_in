import 'package:flutter/material.dart';

void showPlanningDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const PlanningDialog(),
  );
}

class PlanningDialog extends StatelessWidget {
  const PlanningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Placeholder(),
    );
  }
}
