import 'package:flutter/material.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/widgets/quiz_exam_widget.dart';

class QuizExamScreen extends StatefulWidget {
  const QuizExamScreen({super.key});

  @override
  State<QuizExamScreen> createState() => _QuizExamScreenState();
}

class _QuizExamScreenState extends State<QuizExamScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: QuizExamWidget());
  }
}
