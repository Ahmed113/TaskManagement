import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class DateTimeToTzdateTime {
  // Initialize the time zone database
  Future<void> initializeTimeZone() async {
    // Initialize the timezone database (this is necessary to load the time zone data)
    tz.initializeTimeZones();

    // You can directly use the local timezone using tz.local
    // No need to fetch the timezone name using FlutterNativeTimezone
    tz.setLocalLocation(tz.getLocation('UTC'));
  }

  // Convert DateTime to TZDateTime using the local timezone
  static tz.TZDateTime convertToTZDateTime(DateTime dateTime) {
    return tz.TZDateTime.from(dateTime, tz.local); // Convert using tz.local
  }
}
