
import '../backend/services/api_endpoint.dart';
import '../utils/basic_widget_imports.dart';

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }


  double parseDouble() {
    return double.parse(this);
  }
  get toDouble => double.parse(this);
}

extension EndPointExtensions on String {
  String addBaseURl() {
    return ApiEndpoint.baseUrl + this;
  }

  double parseDouble() {
    return double.parse(this);
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}



String makeBalance(String value, [int end = 2]){
  return double.parse(value).toStringAsFixed(end);
}

String makeMultiplyBalance(String value1, String value2, [int end = 2]){
  return (double.parse(value1) * double.parse(value2)).toStringAsFixed(end);
}


Map<String, dynamic> getDate(String dateString){
  DateTime dateTime = DateTime.parse(dateString);

  int day = dateTime.day;
  String month = _getMonthName(dateTime.month);
  int year = dateTime.year;

  debugPrint("day = $day, month = $month, year = $year");
  return {
    "day": day,
    "month": month,
    "year": year
  };
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      return "";
  }
}