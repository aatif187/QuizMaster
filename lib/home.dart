import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmaster/quizpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> Qname = [
    "Shah Rukh Khan",
    "Filmy",
    "IPL",
    "MS Dhoni",
    "Python",
    "C++"
  ];
  List<String> images = [
    "images/srk.jpg",
    "images/filmy.jpg",
    "images/ipl.jpg",
    "images/dhoni.jpg",
    "images/py.png",
    "images/cpp.png",
  ];
  List<String> desc = [
    "So, you think you know Shah Rukh Khan? Take our quiz Here’s a quiz on Shah Rukh Khan’s life. Ace it to prove that you are his biggest fan.",
    "Are you filmy?, Take Our Quiz and show us, how may dialogues you know from the  famous Bollywood movies",
    "Are you a cricket enthusiast, prove your IPL knownledge by taking our IPL quiz and score 10 out 10",
    "Are you A real MSDian, Do you love watching Dhoni on the field. Here's a quiz to show your dhoniasm.",
    "Python is an interpreted, high-level and general-purpose programming language. Created by Guido van Rossum and first released in 1991",
    "C++ is a general-purpose programming language created by Bjarne Stroustrup as an extension of the C programming language.",
  ];
  Widget customcard(String lang, String img, String des) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
              this.context,
              MaterialPageRoute(
                builder: (context) => LoadJSON(lang: lang),
              ));
        },
        child: Material(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.teal[300],
          elevation: 10.0,
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(75.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(img),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    lang,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Quando",
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    des,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: "Alike",
                        color: Colors.white),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz Master",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          customcard(Qname[0], images[0], desc[0]),
          customcard(Qname[1], images[1], desc[1]),
          customcard(Qname[2], images[2], desc[2]),
          customcard(Qname[3], images[3], desc[3]),
          customcard(Qname[4], images[4], desc[4]),
          customcard(Qname[5], images[5], desc[5]),
        ],
      ),
    );
  }
}
