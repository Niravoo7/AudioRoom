import 'package:intl/intl.dart';

//Convert datetime to string
String dateTimeToString(DateTime date) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  return dateFormat.format(date);
}

//Convert string to datetime
DateTime stringToDateTime(String date) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  return dateFormat.parse(date);
}
