import 'package:flutter/foundation.dart';
import '../models/question.dart';

class QuizViewModel extends ChangeNotifier {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isQuizComplete = false;

  // Getter metodları
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  bool get isQuizComplete => _isQuizComplete;
  Question get currentQuestion => _questions[_currentQuestionIndex];

  QuizViewModel() {
    _initializeQuestions();
  }

  void _initializeQuestions() {
    _questions = [
      Question(
        id: '1',
        questionText: 'Türkiye\'nin başkenti neresidir?',
        options: ['İstanbul', 'Ankara', 'İzmir', 'Bursa'],
        correctAnswerIndex: 1,
      ),
      Question(
        id: '2',
        questionText: 'Hangi gezegen Güneş Sisteminin en büyük gezegenidir?',
        options: ['Mars', 'Venüs', 'Jüpiter', 'Satürn'],
        correctAnswerIndex: 2,
      ),
      Question(
        id: '3',
        questionText: 'İnsan vücudundaki en büyük organ hangisidir?',
        options: ['Kalp', 'Beyin', 'Deri', 'Karaciğer'],
        correctAnswerIndex: 2,
      ),
      Question(
        id: '4',
        questionText:
            'Hangi element periyodik tabloda "Fe" sembolü ile gösterilir?',
        options: ['Flor', 'Fosfor', 'Demir', 'Fermiyum'],
        correctAnswerIndex: 2,
      ),
      Question(
        id: '5',
        questionText: 'Hangi yıl Türkiye Cumhuriyeti kurulmuştur?',
        options: ['1920', '1921', '1922', '1923'],
        correctAnswerIndex: 3,
      ),
      Question(
        id: '6',
        questionText: 'DNA\'nın açılımı nedir?',
        options: [
          'Deoksiribo Nükleik Asit',
          'Deribo Nitrik Asit',
          'Deoksiribo Nitrik Asit',
          'Deribo Nükleik Asit'
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        id: '7',
        questionText: 'Hangi gezegen Güneş\'e en yakın gezegendir?',
        options: ['Venus', 'Mars', 'Merkür', 'Dünya'],
        correctAnswerIndex: 2,
      ),
      Question(
        id: '8',
        questionText: 'İstanbul hangi yıl fethedilmiştir?',
        options: ['1453', '1454', '1455', '1456'],
        correctAnswerIndex: 0,
      ),
      Question(
        id: '9',
        questionText: 'Hangi hayvan memeli değildir?',
        options: ['Yarasa', 'Yunus', 'Penguen', 'Kanguru'],
        correctAnswerIndex: 2,
      ),
      Question(
        id: '10',
        questionText: 'Dünyanın en derin okyanusu hangisidir?',
        options: [
          'Atlas Okyanusu',
          'Hint Okyanusu',
          'Pasifik Okyanusu',
          'Arktik Okyanusu'
        ],
        correctAnswerIndex: 2,
      ),
    ];
    notifyListeners();
  }

  void answerQuestion(int selectedIndex) {
    if (selectedIndex == currentQuestion.correctAnswerIndex) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      _isQuizComplete = true;
    }
    notifyListeners();
  }

  void restartQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _isQuizComplete = false;
    notifyListeners();
  }
}
