import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  int trueCount;


  ResultScreen({required this.trueCount});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text("ResultScreen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.trueCount} TRUE ${5-widget.trueCount} FALSE",style: TextStyle(fontSize: 30),),
            Text(" ${((widget.trueCount*100)/5).toInt()}% Success",style: TextStyle(fontSize: 30,color: Colors.pink),),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                child: Text("TRY AGAIN"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
