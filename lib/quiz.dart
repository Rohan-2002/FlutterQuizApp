import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:quiz_app/result_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  //concept used here is render content conditionally 
   String currentScreeState = 'start-screen';
   List<String> selectedAnswers = [];

  void changeScreenState(){
    setState(() {
      currentScreeState = 'Questions-screen';
    });
  }

  void chooseAnswer(String answer){
    selectedAnswers.add(answer);
    if(selectedAnswers.length == questions.length){
      setState(() {
        // selectedAnswers = [];
        currentScreeState = 'result-screen';
      });
    }
  }

    void restartQuiz(){
      setState(() {
        selectedAnswers = [];
        currentScreeState = 'Questions-screen';
      });
    }

  @override
  Widget build(BuildContext context) {
    Widget widgetState = StartScreen(changeScreenState);
    if(currentScreeState == 'Questions-screen'){
      widgetState = QuestionsScreen(onSelectAnswer: chooseAnswer,);
    }

    if(currentScreeState == 'result-screen'){
      widgetState = ResultScreen(chosenAnswers: selectedAnswers,onRestart: restartQuiz,);
    }
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      
      body:Container( 
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 78, 13, 151), 
                    Color.fromARGB(255, 107, 15, 168), 
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
        child: widgetState,
      ),
    ),
  );
  }
}