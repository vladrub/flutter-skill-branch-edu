import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension FormatDate on DateTime {
  String toHumanDate({bool leadingHashSign = true}) {
    final DateTime currentDate = new DateTime.now();
    Duration difference = currentDate.difference(this);

    initializeDateFormatting('ru,', null);

    if (difference.inHours < 1) {
      return 'Менее часа назад.';
    } else if (difference.inHours < 24) {
      return 'Сегодня.';
    } else {
      var newFormat = DateFormat('dd MMM yyyy', 'ru');
      return newFormat.format(this);
    }

    // if (difference.inHours < 1) {
    //   result = 'менее часа назад';
    // } else if (difference.inDays >= 1 ||
    //     (difference.inDays == 0 && currentDate.day > this.day)) {
    //   var newFormat = DateFormat('dd MMM yyyy', 'ru');
    //   result = newFormat.format(this);
    // } else {
    //   result = 'сегодня';
    // }

    // return result;
  }
}
