import 'package:flutter/material.dart';

class FormStep {
  final String title;
  final Widget content;

  FormStep({
    required this.title,
    required this.content,
  });
}

class StepperForm extends StatelessWidget {
  final int currentStep;
  final List<FormStep> steps;
  final VoidCallback onStepContinue;
  final VoidCallback onStepCancel;
  final Widget Function(BuildContext, ControlsDetails)? controlsBuilder;

  const StepperForm({
    super.key,
    required this.currentStep,
    required this.steps,
    required this.onStepContinue,
    required this.onStepCancel,
    this.controlsBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType.vertical,
      currentStep: currentStep,
      onStepContinue: onStepContinue,
      onStepCancel: onStepCancel,
      controlsBuilder: controlsBuilder,
      steps: steps.map((step) {
        return Step(
          title: Text(step.title),
          content: step.content,
          isActive: steps.indexOf(step) <= currentStep,
          state: steps.indexOf(step) < currentStep
              ? StepState.complete
              : StepState.indexed,
        );
      }).toList(),
    );
  }
}

