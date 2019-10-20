import 'package:shared_preferences/shared_preferences.dart';
import 'NotificationDetailes.dart';


class SaveToPref{

  NotificationDetailies prefsND = NotificationDetailies();
  SharedPreferences prefs;

    saveToPref(NotificationDetailies ND) async {
      prefs = await SharedPreferences.getInstance();
      await prefs.setString('Phrase', ND.phrase);
      await prefs.setInt('Days', ND.days);
      await prefs.setInt('NotificationTime', ND.time);
      print(ND);
    }

    LoadData()async{
      prefsND.phrase = await prefs.getString('Phrase');
      prefsND.days = await prefs.getInt('Days');
      prefsND.time =await prefs.getInt('NotificationTime');
    }

    updateDays()async{
      int newDays = await prefs.getInt('Days') - 1;
      prefs.setInt('Days', newDays);
    }
}