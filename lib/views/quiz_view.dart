import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/quiz_view_model.dart';
import 'score_view.dart';
import 'dart:async';

class QuizView extends StatefulWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  late Timer _timer;
  int _timeLeft = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timeLeft = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        timer.cancel();
        final viewModel = context.read<QuizViewModel>();
        viewModel
            .answerQuestion(-1); // Süre dolduğunda yanlış cevap olarak işaretle
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isQuizComplete) {
          return const ScoreView();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Soru ${viewModel.currentQuestionIndex + 1}/${viewModel.questions.length}'),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    'Süre: $_timeLeft',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  viewModel.currentQuestion.questionText,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                ...List.generate(
                  viewModel.currentQuestion.options.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        _timer.cancel();
                        viewModel.answerQuestion(index);
                        if (!viewModel.isQuizComplete) {
                          startTimer();
                        }
                      },
                      child: Text(viewModel.currentQuestion.options[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
