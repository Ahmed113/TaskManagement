import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:permission_handler/permission_handler.dart';


class CalendarService {

  Future<bool> requestCalendarPermission() async {
    PermissionStatus permissionStatus = await Permission.calendarFullAccess.request();
    return permissionStatus.isGranted;
  }

  Future<void> addTaskToCalendar(
      String title,
      String description,
      DateTime endDate,
      ) async {
    // Create an event instance
    final Event event = Event(
      title: title,
      description: description,
      // location: 'Your Location',  // Optional
      startDate: endDate.subtract(Duration(days: 1)),
      endDate: endDate,
    );

    // Add the event to the calendar
    Add2Calendar.addEvent2Cal(event);
  }
}