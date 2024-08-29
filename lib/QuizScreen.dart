import 'dart:collection';

import 'package:flag_quiz_app/Flags.dart';
import 'package:flag_quiz_app/ResultScreen.dart';
import 'package:flag_quiz_app/flagsdao.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var questions = <Flags>[];
  var  wrongOptions= <Flags>[];
  late Flags trueQuestion;
  var allOptions = HashSet<Flags>();

  int questionCount=0;
  int trueCount=0;
  int wrongCount=0;

  String flagImageName = "placeholder.png";
  String buttonAwrite = "";
  String buttonBwrite = "";
  String buttonCwrite = "";
  String buttonDwrite = "";

  @override
  void initState() {
    super.initState();
    takeQuestion();
  }

  Future<void>takeQuestion() async {
    questions = await Flagsdao().cometorandom();
    loadQuestion();
  }
  Future<void>loadQuestion() async {
    trueQuestion = questions[questionCount];

    flagImageName = trueQuestion.flag_image;

    wrongOptions = await Flagsdao().cometoWrongrandom(trueQuestion.flag_id);

    allOptions.clear();
    allOptions.add(trueQuestion);
    allOptions.add(wrongOptions[0]);
    allOptions.add(wrongOptions[1]);
    allOptions.add(wrongOptions[2]);

    buttonAwrite = allOptions.elementAt(0).flag_name;
    buttonBwrite = allOptions.elementAt(1).flag_name;
    buttonCwrite = allOptions.elementAt(2).flag_name;
    buttonDwrite = allOptions.elementAt(3).flag_name;

    setState(() {
    });
  }

  void questionCountControl(){
    questionCount = questionCount + 1;

    if(questionCount != 5){
      loadQuestion();
    }else{
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ResultScreen(trueCount: trueCount,)));
    }
  }

  void trueControl(String buttonWrite){
    if(trueQuestion.flag_name == buttonWrite){
      trueCount = trueCount + 1;
    }else{
      wrongCount= wrongCount + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("QuizScreen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("True : $trueCount",style:TextStyle(fontSize: 18),),
                Text("False : $wrongCount",style:TextStyle(fontSize: 18),),
              ],
            ),
            questionCount != 5 ? Text("Question ${questionCount+1}",style:TextStyle(fontSize: 30),) :
            Text("Question 5",style:TextStyle(fontSize: 30),),
            Image.asset("resimler/$flagImageName"),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text(buttonAwrite),
                onPressed: (){
                  trueControl(buttonAwrite);
                  questionCountControl();

                },
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text(buttonBwrite),
                onPressed: (){
                  trueControl(buttonBwrite);
                  questionCountControl();

                },
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text(buttonCwrite),
                onPressed: (){
                  trueControl(buttonCwrite);
                  questionCountControl();

                },
              ),
            ),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text(buttonDwrite),
                onPressed: (){
                  trueControl(buttonDwrite);
                  questionCountControl();

                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}