import 'package:intl/intl.dart';

String formatDate(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);
  DateFormat formatter = DateFormat('EEEE, MMM d, yyyy');
  return formatter.format(dateTime);
}
