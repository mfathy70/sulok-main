

import 'package:flutter/foundation.dart';

String _default = 'en';

Map<String, LookupMessages> _lookupMessagesMap = {
  'ar': ArMessages(),
};


void setDefaultLocale(String locale) {
  assert(_lookupMessagesMap.containsKey(locale),
  '[locale] must be a registered locale');
  _default = locale;
}

void setLocaleMessages(String locale, LookupMessages lookupMessages) {
  _lookupMessagesMap[locale] = lookupMessages;
}
String format(DateTime date,
    {String? locale, DateTime? clock, bool allowFromNow = false}) {
  final locale0 = locale ?? _default;
  if (_lookupMessagesMap[locale0] == null) {
    if (kDebugMode) {
      print("Locale [$locale0] has not been added, using [$_default] as fallback. To add a locale use [setLocaleMessages]");
    }
  }
  final allowFromNow0 = allowFromNow;
  final messages = _lookupMessagesMap[locale0] ?? ArMessages();
  final clock0 = clock ?? DateTime.now();
  var elapsed = clock0.millisecondsSinceEpoch - date.millisecondsSinceEpoch;

  String prefix, suffix;

  if (allowFromNow0 && elapsed < 0) {
    elapsed = date.isBefore(clock0) ? elapsed : elapsed.abs();
    prefix = messages.prefixFromNow();
    suffix = messages.suffixFromNow();
  } else {
    prefix = messages.prefixAgo();
    suffix = messages.suffixAgo();
  }

  final num seconds = elapsed / 1000;
  final num minutes = seconds / 60;
  final num hours = minutes / 60;
  final num days = hours / 24;
  final num months = days / 30;
  final num years = days / 365;

  String result;
  if (seconds < 45) {
    result = messages.lessThanOneMinute(seconds.round());
  } else if (seconds < 90) {
    result = messages.aboutAMinute(minutes.round());
  } else if (minutes < 45) {
    result = messages.minutes(minutes.round());
  } else if (minutes < 90) {
    result = messages.aboutAnHour(minutes.round());
  } else if (hours < 24) {
    result = messages.hours(hours.round());
  } else if (hours < 48) {
    result = messages.aDay(hours.round());
  } else if (days < 30) {
    result = messages.days(days.round());
  } else if (days < 60) {
    result = messages.aboutAMonth(days.round());
  } else if (days < 365) {
    result = messages.months(months.round());
  } else if (years < 2) {
    result = messages.aboutAYear(months.round());
  } else {
    result = messages.years(years.round());
  }

  return [prefix, result, suffix]
      .where((str) => str.isNotEmpty)
      .join(messages.wordSeparator());
}
abstract class LookupMessages {
  String prefixAgo();
  String prefixFromNow();
  String suffixAgo();
  String suffixFromNow();
  String lessThanOneMinute(int seconds);
  String aboutAMinute(int minutes);
  String minutes(int minutes);
  String aboutAnHour(int minutes);
  String hours(int hours);
  String aDay(int hours);
  String days(int days);
  String aboutAMonth(int days);
  String months(int months);
  String aboutAYear(int year);
  String years(int years);
  String wordSeparator() => ' ';
}

class ArMessages implements LookupMessages {
  @override
  String prefixAgo() => 'منذ';
  @override
  String prefixFromNow() => 'بعد';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';

  @override
  String lessThanOneMinute(int seconds) {
    if (seconds == 1) {
      return 'ثانية واحدة';
    } else if (seconds == 2) {
      return 'ثانيتين';
    } else if (seconds > 2 && seconds < 11) {
      return '$seconds ثواني';
    } else {
      return '$seconds ثانية';
    }
  }

  @override
  String aboutAMinute(int minutes) => 'دقيقة تقريباً';


  @override
  String minutes(int minutes) {
    if (minutes == 2) {
      return 'دقيقتين';
    } else if (minutes > 2 && minutes < 11) {
      return '$minutes دقائق';
    } else {
      return '$minutes دقيقة';
    }
  }

  @override
  String aboutAnHour(int minutes) => 'ساعة تقريباً';
  @override
  String hours(int hours) {
    if (hours == 2) {
      return 'ساعتين';
    } else if (hours > 2 && hours < 11) {
      return '$hours ساعات';
    } else {
      return '$hours ساعة';
    }
  }

  @override
  String aDay(int hours) => 'يوم';
  @override
  String days(int days) {
    if (days == 2) {
      return 'يومين';
    } else if (days > 2 && days < 11) {
      return '$days ايام';
    } else {
      return '$days يوم';
    }
  }

  @override
  String aboutAMonth(int days) => 'شهر تقريباً';
  @override
  String months(int months) {
    if (months == 2) {
      return 'شهرين';
    } else if (months > 2 && months < 11) {
      return '$months اشهر';
    } else if (months > 10) {
      return '$months شهر';
    }
    return '$months شهور';
  }

  @override
  String aboutAYear(int year) => 'سنة تقريباً';
  @override
  String years(int years) {
    if (years == 2) {
      return 'سنتين';
    } else if (years > 2 && years < 11) {
      return '$years سنوات';
    } else {
      return '$years سنة';
    }
  }

  @override
  String wordSeparator() => ' ';
}

class ArShortMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => '$seconds ثا';
  @override
  String aboutAMinute(int minutes) => '~1 د';
  @override
  String minutes(int minutes) => '$minutes د';
  @override
  String aboutAnHour(int minutes) => '~1 س';
  @override
  String hours(int hours) => '$hours س';
  @override
  String aDay(int hours) => '~1 ي';
  @override
  String days(int days) => '$days ي';
  @override
  String aboutAMonth(int days) => '~1 ش';
  @override
  String months(int months) => '$months ش';
  @override
  String aboutAYear(int year) => '~1 س';
  @override
  String years(int years) => '$years س';
  @override
  String wordSeparator() => ' ';
}
