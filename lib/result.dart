import 'package:flutter/material.dart';
import 'package:quizmaster/home.dart';

class EndPage extends StatefulWidget {
  int marks;
  EndPage({Key key, @required this.marks}) : super(key: key);
  @override
  _EndPageState createState() => _EndPageState(marks);
}

class _EndPageState extends State<EndPage> {
  List<String> images = [
    "images/success.png",
    "images/good.png",
    "images/bad.png",
  ];
  String img;
  String msg;
  @override
  void initState() {
    if (marks <= 4) {
      img = images[2];
      msg = "Your score is $marks out of 10.\nYou should work hard.";
    } else if (marks <= 8) {
      img = images[1];
      msg = "Your score is $marks out of 10.\nYou can do better.";
    } else {
      img = images[0];
      msg = "Your score is $marks out of 10.\nYou did pretty well.";
    }
    super.initState();
  }

  int marks;
  _EndPageState(this.marks);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz Master: Result",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        height: 300.0,
                        width: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              img,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                      child: Center(
                        child: Text(
                          msg,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: "Quando",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontFamily: "Times New Roman",
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  splashColor: Colors.cyan,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  borderSide: BorderSide(
                    width: 3.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
