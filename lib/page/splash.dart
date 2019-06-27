import 'package:combustivel_ideal/page/posto.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((_) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => PostoPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
//    Container nome = Container(
//        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
//        child: Text("EDMM COMBUSTÍVEL",
//          style: TextStyle(fontSize: 30.0, color: Colors.green),));

    return Scaffold(
      body: Container(
//                  margin:EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0) ,
//                  child: Text("EDMM COMBUSTÍVEL",
//                      style: TextStyle(fontSize: 30.0, color: Color(0xFF00b402)
//                      ),
//                  ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/gas.png")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}