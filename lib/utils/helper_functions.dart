import 'package:intl/intl.dart';

String getFormattedDateTime(DateTime dateTime, String pattern) =>
    DateFormat(pattern).format(dateTime);
