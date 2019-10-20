import 'package:flutter/material.dart';
import 'package:counttomev02/SetNotificationDetailiesPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Count Me Down',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
 }

}

class MyHomePage extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Count Me Down'),
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/countdown.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(children: <Widget>[
          Positioned(
            top: 50.0,
            left: 40.0,
            child: Text(
              'Let\'s ',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 100.0,
            left: 50.0,
            child: Text(
              'start our counting ',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
              child: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.amber,
                size: 70.0,
              ),
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
            ),
          ),
        ]),
      ),
    );
  }
}

/**For page animated transition **/

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Page2(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 20.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),

          child: child,
        );
      });
}

