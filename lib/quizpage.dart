import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaster/result.dart';

class LoadJSON extends StatelessWidget {
  Map<String, String> language = {
    "Shah Rukh Khan": "assets/srk.json",
    "Filmy": "assets/filmy.json",
    "IPL": "assets/ipl.json",
    "MS Dhoni": "assets/dhoni.json",
    "C++": "assets/cpp.json",
    "Python": "assets/python.json",
  };

  String lang;
  LoadJSON({this.lang});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(language[lang]),
        builder: (context, snapshot) {
          List mydata = json.decode(snapshot.data.toString());
          if (mydata == null) {
            return Scaffold(
              body: Center(
                child: Text(
                  "loading..",
                ),
              ),
            );
          } else {
            return QuizPage(mydata: mydata);
          }
        },
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  List mydata;
  QuizPage({Key key, @required this.mydata}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState(mydata: mydata);
}

class _QuizPageState extends State<QuizPage> {
  var mydata;

  _QuizPageState({this.mydata});
  Color colorshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
    "d": Colors.indigoAccent
  };
  @override
  void initState() {
    starttimer();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  int timer = 20;
  String timetoshow = "20";
  void starttimer() {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer--;
        }
        timetoshow = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 20;
    setState(() {
      if (i < 10) {
        i++;
      } else {
        //end screen
        Navigator.of(this.context).pushReplacement(MaterialPageRoute(
          builder: (context) => EndPage(marks: marks),
        ));
      }
      btncolor["a"] = Colors.indigoAccent;
      btncolor["b"] = Colors.indigoAccent;
      btncolor["c"] = Colors.indigoAccent;
      btncolor["d"] = Colors.indigoAccent;
    });
    starttimer();
  }

  bool canceltimer = false;
  void checkanswer(String ans) {
    if (mydata[2][i.toString()] == mydata[1][i.toString()][ans]) {
      // answer correct
      marks += 1;
      colorshow = right;
    } else {
      //answer wrong
      colorshow = wrong;
    }
    setState(() {
      btncolor[ans] = colorshow;
      canceltimer = true;
    });
    Timer(Duration(seconds: 1), nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
            fontFamily: "Alike",
            color: Colors.white,
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btncolor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 40.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Quiz Master",
            ),
            content: Text(
              "You Can't go back Untill you Finish !!",
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                ),
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Quiz Mater",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.teal[300],
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(18.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  mydata[0][i.toString()],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Quando",
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    choicebutton('a'),
                    choicebutton('b'),
                    choicebutton('c'),
                    choicebutton('d'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  timetoshow,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: "Times New Roman",
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[900],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
