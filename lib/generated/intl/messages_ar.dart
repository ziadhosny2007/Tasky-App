// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(value) => "${value}";

  static String m1(category, time) => "${category} • ${time}";

  static String m2(completed, total) =>
      "${Intl.plural(total, one: 'أنجزت ${completed} من مهمة واحدة', two: 'أنجزت ${completed} من مهمتين', few: 'أنجزت ${completed} من ${total} مهام', many: 'أنجزت ${completed} من ${total} مهمة', other: 'أنجزت ${completed} من ${total} مهمة')}";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'لا توجد مهام', one: 'مهمة واحدة', two: 'مهمتان', few: '${count} مهام', many: '${count} مهمة', other: '${count} مهمة')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addTitle": MessageLookupByLibrary.simpleMessage("أضف عنوانًا"),
    "appName": MessageLookupByLibrary.simpleMessage("Taskly"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "categories": MessageLookupByLibrary.simpleMessage("التصنيفات"),
    "categoryHealth": MessageLookupByLibrary.simpleMessage("الصحة"),
    "categoryPersonal": MessageLookupByLibrary.simpleMessage("شخصي"),
    "categoryShopping": MessageLookupByLibrary.simpleMessage("التسوق"),
    "categoryWork": MessageLookupByLibrary.simpleMessage("العمل"),
    "clearCompletedTasks": MessageLookupByLibrary.simpleMessage(
      "مسح المهام المكتملة",
    ),
    "darkMode": MessageLookupByLibrary.simpleMessage("الوضع الداكن"),
    "descriptionHint": MessageLookupByLibrary.simpleMessage(
      "أضف تفاصيل (اختياري)",
    ),
    "done": MessageLookupByLibrary.simpleMessage("تم"),
    "editProfile": MessageLookupByLibrary.simpleMessage("تعديل الملف الشخصي"),
    "enterTitleError": MessageLookupByLibrary.simpleMessage(
      "من فضلك أدخل عنوانًا",
    ),
    "fieldCategory": MessageLookupByLibrary.simpleMessage("التصنيف"),
    "fieldDateTime": MessageLookupByLibrary.simpleMessage("التاريخ والوقت"),
    "fieldDescription": MessageLookupByLibrary.simpleMessage("الوصف"),
    "fieldPriority": MessageLookupByLibrary.simpleMessage("الأولوية"),
    "fieldTitle": MessageLookupByLibrary.simpleMessage("العنوان"),
    "getStarted": MessageLookupByLibrary.simpleMessage("ابدأ الآن"),
    "homeTitle": MessageLookupByLibrary.simpleMessage(
      "ماذا تريد أن تنجز اليوم؟",
    ),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "navCalendar": MessageLookupByLibrary.simpleMessage("التقويم"),
    "navProfile": MessageLookupByLibrary.simpleMessage("حسابي"),
    "navToday": MessageLookupByLibrary.simpleMessage("اليوم"),
    "newTask": MessageLookupByLibrary.simpleMessage("مهمة جديدة"),
    "next": MessageLookupByLibrary.simpleMessage("التالي"),
    "noTasksToday": MessageLookupByLibrary.simpleMessage("لا توجد مهام اليوم"),
    "noTasksYet": MessageLookupByLibrary.simpleMessage("لا توجد مهام بعد"),
    "onboarding1Body": MessageLookupByLibrary.simpleMessage(
      "رتّب مهامك في العمل والشخصي والتسوق والصحة حتى لا يضيع شيء.",
    ),
    "onboarding1Title": MessageLookupByLibrary.simpleMessage(
      "كل مهمة في مكانها",
    ),
    "onboarding2Body": MessageLookupByLibrary.simpleMessage(
      "حدد المهام بأولوية منخفضة أو متوسطة أو عالية وابدأ يومك بالأهم.",
    ),
    "onboarding2Title": MessageLookupByLibrary.simpleMessage("ركّز على المهم"),
    "onboarding3Body": MessageLookupByLibrary.simpleMessage(
      "تابع تقدمك اليومي وهو يمتلئ، وكوّن عادة إنجاز المهام.",
    ),
    "onboarding3Title": MessageLookupByLibrary.simpleMessage("شاهد تقدمك يكبر"),
    "preferences": MessageLookupByLibrary.simpleMessage("التفضيلات"),
    "priorityHigh": MessageLookupByLibrary.simpleMessage("عالية"),
    "priorityLow": MessageLookupByLibrary.simpleMessage("منخفضة"),
    "priorityMedium": MessageLookupByLibrary.simpleMessage("متوسطة"),
    "profileCompleted": MessageLookupByLibrary.simpleMessage("المكتملة"),
    "profilePending": MessageLookupByLibrary.simpleMessage("المعلّقة"),
    "profileTotal": MessageLookupByLibrary.simpleMessage("الإجمالي"),
    "progressPercent": m0,
    "reminders": MessageLookupByLibrary.simpleMessage("التذكيرات"),
    "saveTask": MessageLookupByLibrary.simpleMessage("حفظ المهمة"),
    "settings": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "skip": MessageLookupByLibrary.simpleMessage("تخطي"),
    "taskMeta": m1,
    "tasksCompletedOf": m2,
    "tasksCount": m3,
    "titleHint": MessageLookupByLibrary.simpleMessage("خطط للأسبوع"),
    "todaysProgress": MessageLookupByLibrary.simpleMessage("تقدم اليوم"),
    "todaysTasks": MessageLookupByLibrary.simpleMessage("مهام اليوم"),
    "totalTasks": MessageLookupByLibrary.simpleMessage("إجمالي المهام"),
  };
}
