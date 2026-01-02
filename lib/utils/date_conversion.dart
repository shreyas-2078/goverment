import 'package:intl/intl.dart';


class DateTimeConversion {
  DateTimeConversion._internal();
  static final DateTimeConversion _instance = DateTimeConversion._internal();
  factory DateTimeConversion() => _instance;

  static String _dateFormat = 'dd-MM-yyyy'; // Default format

  /// ✅ Setter to update date format dynamically from API
  static set dateFormat(String value) {
    if (value.isNotEmpty) {
      _dateFormat = value;
    }
  }

  static String get dateFormat => _dateFormat;

  /// Reset to default format
  static void resetToDefault() {
    _dateFormat = 'dd-MM-yyyy';
  }

  static String formatDateString(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '--';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat(_dateFormat).format(date);
    } catch (e) {
      return '--';
    }
  }

  static String formatDateTime(DateTime? date) {
    if (date == null) return '--';
    try {
      return DateFormat(_dateFormat).format(date);
    } catch (e) {
      return '--';
    }
  }

static String formatDateStringS(String? dateString) {
  if (dateString == null || dateString.isEmpty) return '--';
  try {
    final date = DateTime.parse(dateString);
    // Optionally, convert to local time if you want to show local time:
    // final localDate = date.toLocal();
    return DateFormat(_dateFormat).format(date);
  } catch (e) {
    return '--';
  }
}

  static String formatDateStringProfile(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '--';
    try {
      final date = DateTime.parse(dateStr).toLocal();
      return DateFormat(_dateFormat).format(date);
    } catch (e) {
      return '--';
    }
  }

  static String formatIsoTime(String? isoTime) {
    if (isoTime == null || isoTime.isEmpty) return "--";
    try {
      final dateTime = DateTime.parse(isoTime).toLocal();
      return DateFormat('h:mm:ss a').format(dateTime);
    } catch (e) {
      return "--";
    }
  }

  static String formatDate(DateTime? date) {
    if (date == null) return "--";
    try {
      return DateFormat(_dateFormat).format(date);
    } catch (e) {
      return "--";
    }
  }

  static String formatTime(DateTime? time) {
    if (time == null) return "--";
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  static String formatHeaderDate(DateTime date) {
    try {
      final day = DateFormat('d').format(date);
      final month = DateFormat('MMMM').format(date);
      final year = date.year.toString();
      return '$year $month $day';
    } catch (e) {
      return '--';
    }
  }

  static String libraryformatDate(DateTime date) {
    try {
      return DateFormat('$_dateFormat HH:mm').format(date);
    } catch (e) {
      return '--';
    }
  }

  static String formatDateTimeString(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "--";
    try {
      final dateTime = DateTime.parse(dateStr).toLocal();
      final datePart = DateFormat(_dateFormat).format(dateTime);
      final timePart = DateFormat('hh:mm a').format(dateTime);
      return "$datePart $timePart";
    } catch (e) {
      return "--";
    }
  }

  static String mapShiftStatus(String shift) {
    switch (shift.toLowerCase()) {
      case "available":
        return "Available";
      case "less-preferred":
        return "Less Preferred";
      case "not-available":
        return "Not Available";
      default:
        return "--- : ---";
    }
  }

  static String librarytruncateId(String id) {
    return id.length > 8 ? '${id.substring(0, 8)}...' : id;
  }



static String formatFlexibleDateString(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return '--';
  try {
    // Try ISO first
    return DateFormat(_dateFormat).format(DateTime.parse(dateStr));
  } catch (_) {
    try {
      // Try custom format
      final inputFormat = DateFormat('yyyy MMMM dd');
      final date = inputFormat.parse(dateStr);
      return DateFormat(_dateFormat).format(date);
    } catch (e) {
      return '--';
    }
  }
}


static String formatDateStrings(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return '--';
  DateTime? date;
  // Try ISO first
  try {
    date = DateTime.parse(dateStr);
  } catch (_) {
    
    final formats = [
      DateFormat('dd MMM yyyy'),   
      DateFormat('yyyy-MM-dd'),    
      DateFormat('yyyy/MM/dd'),    
      DateFormat('yyyy MMM dd'),   
      DateFormat('yyyy MMMM dd'),  
      DateFormat('dd-MM-yyyy'),    
      DateFormat('dd/MM/yyyy'),    
    ];
    for (final format in formats) {
      try {
        date = format.parse(dateStr);
        break;
      } catch (_) {}
    }
  }
  if (date == null) {
    return '--';
  }
  return DateFormat(_dateFormat).format(date);
}

static String formatDateStringsWithIST(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return '--';
  DateTime? date;
  
  try {
    date = DateTime.parse(dateStr);
  } catch (_) {
    final formats = [
      DateFormat('dd MMM yyyy'),   
      DateFormat('yyyy-MM-dd'),    
      DateFormat('yyyy/MM/dd'),    
      DateFormat('yyyy MMM dd'),   
      DateFormat('yyyy MMMM dd'),  
      DateFormat('dd-MM-yyyy'),    
      DateFormat('dd/MM/yyyy'),    
    ];
    for (final format in formats) {
      try {
        date = format.parse(dateStr);
        break;
      } catch (_) {}
    }
  }
  
  if (date == null) {
    return '--';
  }
  
  final istDate = date.toUtc().add(const Duration(hours: 5, minutes: 30));
  
  return DateFormat(_dateFormat).format(istDate);
}

static String formatDateTimeWithIST(DateTime? date) {
  if (date == null) return '--';
  
  final istDate = date.toUtc().add(const Duration(hours: 5, minutes: 30));
  
  return DateFormat(_dateFormat).format(istDate);
}

static DateTime convertUTCToIST(DateTime utcDate) {
  return utcDate.toUtc().add(const Duration(hours: 5, minutes: 30));
}


static String formatBackendDateWithIST(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return '--';
  
  try {
    // Parse the date string (assuming it's in UTC from backend)
    final utcDate = DateTime.parse(dateStr);
    
    // Convert to IST
    final istDate = convertUTCToIST(utcDate);
    
    // Format using the current date format
    return DateFormat(_dateFormat).format(istDate);
  } catch (e) {
    return '--';
  }
}


static String formatDateDynamic(String? dateStr, {String? outputFormat}) {
  if (dateStr == null || dateStr.isEmpty) return '--';
  DateTime? date;

  // Helper to capitalize month if needed (for e.g. "2025 jul 21")
  String capitalizeMonth(String input) {
    final parts = input.split(' ');
    if (parts.length == 3) {
      parts[1] = parts[1][0].toUpperCase() + parts[1].substring(1).toLowerCase();
      return parts.join(' ');
    }
    return input;
  }

  // 1. Try parsing with the dynamic _dateFormat first
  try {
    date = DateFormat(_dateFormat).parse(dateStr);
  } catch (_) {
    // 2. Try ISO format
    try {
      date = DateTime.parse(dateStr);
    } catch (_) {
      // 3. Try other common formats, including capitalized month
      final fallbackFormats = [
        DateFormat('yyyy-MM-dd'),
        DateFormat('yyyy/MM/dd'),
        DateFormat('yyyy MMMM dd'),
        DateFormat('yyyy MMM dd'),
        DateFormat('dd-MM-yyyy'),
        DateFormat('dd/MM/yyyy'),
        DateFormat('dd MMM yyyy'),
        DateFormat('yyyy-MM-ddTHH:mm:ss'),
        DateFormat('yyyy-MM-dd HH:mm:ss'),
      ];
      for (final format in fallbackFormats) {
        try {
          date = format.parse(dateStr);
          break;
        } catch (_) {
          // Try with capitalized month
          try {
            date = format.parse(capitalizeMonth(dateStr));
            break;
          } catch (_) {}
        }
      }
    }
  }

  if (date == null) return '--';
  final formatString = outputFormat ?? _dateFormat;
  return DateFormat(formatString).format(date);
}

static String formatCalendarHeader(DateTime date) {
  try {
    return DateFormat('d MMM yyyy').format(date);
  } catch (e) {
    return '--';
  }
}

/// Convert UTC time string to IST and format as 12-hour time (e.g., "09:30 AM", "09:20 PM")
static String formatTimeStringWithIST(String? timeStr) {
  if (timeStr == null || timeStr.isEmpty) return 'N/A';
  try {
    // Parse the time string as UTC (assuming format like "09:30:00" or "21:20:00")
    DateTime utcTime;
    if (timeStr.contains('T')) {
      // Full datetime string
      utcTime = DateTime.parse(timeStr);
    } else {
      // Just time string, create a date with it
      utcTime = DateTime.parse("2023-01-01 $timeStr");
    }
    // Convert to IST (add 5:30 hours)
    final istTime = utcTime.add(const Duration(hours: 5, minutes: 30));
    // Format as 12-hour time
    return DateFormat('hh:mm a').format(istTime);
  } catch (e) {
    return timeStr; // Return original if parsing fails
  }
}

/// Convert UTC DateTime to IST and format as 12-hour time
static String formatTimeWithIST(DateTime? time) {
  if (time == null) return 'N/A';
  try {
    final istTime = time.toUtc().add(const Duration(hours: 5, minutes: 30));
    return DateFormat('hh:mm a').format(istTime);
  } catch (e) {
    return 'N/A';
  }
}

}