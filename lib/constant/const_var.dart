import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../constant/time_ago.dart' as timeago;
import 'app_colors.dart';

class ConstVars {
  static final DateFormat format = DateFormat('dd/MM/yyyy', 'ar');

  static String timeAgo(DateTime? time) {
    if (time == null) return '';
    return timeago.format(time, locale: 'ar');
  }

  static List<BoxShadow> amberBoxShadow = [
    BoxShadow(
      color: AppColors.amberSecond.withOpacity(0.2),
      spreadRadius: 5 ,
      blurRadius: 8,
      offset: const Offset(0, 22), // changes position of shadow
    ),
  ];
}
