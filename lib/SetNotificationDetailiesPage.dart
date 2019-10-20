import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'NotificationDetailes.dart';
import 'SaveToPref.dart';
import 'SetNotification.dart';


class Page2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Page2();
  }
}

class _Page2 extends State<Page2> {
  static final myController = new TextEditingController();
  var current_step = 0;
  static NotificationDetailies ND = new NotificationDetailies();

  //List of steps widget
  List<Step> steps = [
    Step(
      title: Text(
        'Set Your Motivitional Phrase For The Countdown',
        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
      ),
      content: TextField(
        controller: myController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
      isActive: true,
    ),

    Step(
      title: Text(
        'End Date',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
      ),
      content: Container(
          height: 130.0,
          width: 300.0,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newdate) {
              ND.days = newdate.difference(DateTime.now()).inDays;
              print(ND.days);
            },
            mode: CupertinoDatePickerMode.date,
          )),
      isActive: true,
    ),

    Step(
      title: Text(
        'Time To Notify',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
      ),
      content: Container(
          height: 130.0,
          width: 300.0,
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (DateTime newdate) {
              ND.time = newdate.hour;
            },
            mode: CupertinoDatePickerMode.time,
          )),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back_ios,
            color: Colors.amber,
            size: 40.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Stepper(
              steps: steps,
              currentStep: this.current_step,
              type: StepperType.vertical,
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Row(
                  children: <Widget>[
                    FlatButton(
                      onPressed: onStepContinue,
                      child: const Text('Save'),
                      color: Colors.red,
                    ),
                  ],
                );
              },
              onStepTapped: (step) {
                setState(() {
                  current_step = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (current_step < steps.length - 1) {
                    current_step = current_step + 1;
                  } else {
                    current_step = 0;
                  }
                });
              },
            ),
          ),
          Positioned(
            top: 10.0,
            left: 30.0,
            child: Container(
              height: 95.0,
              width: 95.0,
              child: Image.asset('images/sandclock.png'),
            ),
          ),
          Positioned(
            top: 50.0,
            left: 140.0,
            child: Text(
              'Follow Steps',
              style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w600),
            ),
          ),
          Positioned(
              bottom: 20.0,
              left: 170.0,
              child: MaterialButton(
                child: Icon(
                  Icons.add_circle_outline,
                  size: 50.0,
                  color: Colors.red,
                ),
                onPressed: () {
                  ND.phrase = myController.text;
                  SaveToPref sv = new SaveToPref();
                  sv.saveToPref(ND);
                  SetNotification st = new SetNotification();
                  st.secduledNotification();
                },
              )),
        ],
      ),
    );
  }
}


