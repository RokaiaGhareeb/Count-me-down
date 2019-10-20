import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'SaveToPref.dart';
import 'NotificationDetailes.dart';

class SetNotification {
  SaveToPref STP = new SaveToPref();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  secduledNotification() async {
    NotificationDetailies ND = STP.LoadData();
    print(ND.days);
    var time = new Time(ND.time,10,0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '1', 'inducesmile', 'inducesmile flutter snippets',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(0, ND.phrase, 'Just ${ND.days} Left, Stay Calm ', time,platformChannelSpecifics);
    print(flutterLocalNotificationsPlugin);
    STP.updateDays();
    print(ND.days);
  }

  initNotifications() async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = new AndroidInitializationSettings('sandclock.png');
    var initializationSettingsIOS = new IOSInitializationSettings(onDidReceiveLocalNotification: (i, string1, string2, string3) {
      print("received notifications");
    });
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (string) {
      print("selected notification");
    });
  }
}
