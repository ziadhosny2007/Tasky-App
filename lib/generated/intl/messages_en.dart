// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(value) => "${value}";

  static String m1(category, time) => "${category} • ${time}";

  static String m2(completed, total) =>
      "${Intl.plural(total, one: '${completed} of 1 task completed', other: '${completed} of ${total} tasks completed')}";

  static String m3(count) =>
      "${Intl.plural(count, one: '1 task', other: '${count} tasks')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addTitle": MessageLookupByLibrary.simpleMessage("Add Title"),
    "appName": MessageLookupByLibrary.simpleMessage("Taskly"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "categories": MessageLookupByLibrary.simpleMessage("Categories"),
    "categoryHealth": MessageLookupByLibrary.simpleMessage("Health"),
    "categoryPersonal": MessageLookupByLibrary.simpleMessage("Personal"),
    "categoryShopping": MessageLookupByLibrary.simpleMessage("Shopping"),
    "categoryWork": MessageLookupByLibrary.simpleMessage("Work"),
    "clearCompletedTasks": MessageLookupByLibrary.simpleMessage(
      "Clear completed tasks",
    ),
    "darkMode": MessageLookupByLibrary.simpleMessage("Dark mode"),
    "descriptionHint": MessageLookupByLibrary.simpleMessage(
      "Add details (optional)",
    ),
    "done": MessageLookupByLibrary.simpleMessage("Done"),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit profile"),
    "enterTitleError": MessageLookupByLibrary.simpleMessage(
      "Please enter a title",
    ),
    "fieldCategory": MessageLookupByLibrary.simpleMessage("Category"),
    "fieldDateTime": MessageLookupByLibrary.simpleMessage("Date and time"),
    "fieldDescription": MessageLookupByLibrary.simpleMessage("Description"),
    "fieldPriority": MessageLookupByLibrary.simpleMessage("Priority"),
    "fieldTitle": MessageLookupByLibrary.simpleMessage("Title"),
    "getStarted": MessageLookupByLibrary.simpleMessage("Get started"),
    "homeTitle": MessageLookupByLibrary.simpleMessage(
      "What do you want to do today?",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "navCalendar": MessageLookupByLibrary.simpleMessage("Calendar"),
    "navProfile": MessageLookupByLibrary.simpleMessage("Profile"),
    "navToday": MessageLookupByLibrary.simpleMessage("Today"),
    "newTask": MessageLookupByLibrary.simpleMessage("New task"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noTasksToday": MessageLookupByLibrary.simpleMessage(
      "There are no tasks today",
    ),
    "noTasksYet": MessageLookupByLibrary.simpleMessage("No tasks yet"),
    "onboarding1Body": MessageLookupByLibrary.simpleMessage(
      "Sort your to-dos into Work, Personal, Shopping and Health so nothing gets lost.",
    ),
    "onboarding1Title": MessageLookupByLibrary.simpleMessage(
      "Keep every task in its place",
    ),
    "onboarding2Body": MessageLookupByLibrary.simpleMessage(
      "Mark tasks Low, Medium or High and start your day with the ones that count.",
    ),
    "onboarding2Title": MessageLookupByLibrary.simpleMessage(
      "Focus on what matters",
    ),
    "onboarding3Body": MessageLookupByLibrary.simpleMessage(
      "Watch your daily progress fill up and build a habit of finishing.",
    ),
    "onboarding3Title": MessageLookupByLibrary.simpleMessage(
      "See your progress grow",
    ),
    "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
    "priorityHigh": MessageLookupByLibrary.simpleMessage("High"),
    "priorityLow": MessageLookupByLibrary.simpleMessage("Low"),
    "priorityMedium": MessageLookupByLibrary.simpleMessage("Medium"),
    "profileCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "profilePending": MessageLookupByLibrary.simpleMessage("Pending"),
    "profileTotal": MessageLookupByLibrary.simpleMessage("Total"),
    "progressPercent": m0,
    "reminders": MessageLookupByLibrary.simpleMessage("Reminders"),
    "saveTask": MessageLookupByLibrary.simpleMessage("Save task"),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "taskMeta": m1,
    "tasksCompletedOf": m2,
    "tasksCount": m3,
    "titleHint": MessageLookupByLibrary.simpleMessage("Plan the week"),
    "todaysProgress": MessageLookupByLibrary.simpleMessage("Today’s progress"),
    "todaysTasks": MessageLookupByLibrary.simpleMessage("Today’s tasks"),
    "totalTasks": MessageLookupByLibrary.simpleMessage("Total tasks"),
  };
}
