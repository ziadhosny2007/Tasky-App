import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tasky/core/db/sqldb.dart';
import 'package:tasky/core/themes/app_colors.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late final TextEditingController title;
  late final TextEditingController des;
  Sqldb db = Sqldb();
  Future<int> insertTask({
    required String title,
    required String des,
    required String category,
    required String time,
    required String date,
    required int priority,
  }) async {
     return await db.insertData('''
    INSERT INTO tasks (task, des, category, time, date, priority, is_done)
    VALUES ('$title', '$des', '$category', '$time', '$date', $priority, ${0})''');
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List<Map> prority = [
    {"name": "Low", "color": Color(0xff3DBE8B)},
    {"name": "Medium", "color": Color(0xffF5A524)},
    {"name": "High", "color": Color(0xffE5484D)},
  ];
  List<Map> categories = [
    {"icon": Icons.work, "title": "Work"},
    {"icon": Icons.person, "title": "Personal"},
    {"icon": Icons.shopping_bag_outlined, "title": "Shopping"},
    {"icon": Icons.favorite_border_outlined, "title": "Health"},
  ];
  int selectedIndex = 1;
  int selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    title = TextEditingController();
    des = TextEditingController();
  }

  @override
  void dispose() {
    title.dispose();
    des.dispose();
    super.dispose();
  }

  void _showWheelSheet({required Widget picker, required VoidCallback onDone}) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Theme.of(context).brightness,
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: TextStyle(
              fontSize: 20,
              color: Theme.of(context).highlightColor,
            ),
          ),
        ),
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancel'),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      onDone();
                      Navigator.pop(ctx);
                    },
                    child: const Text('Done'),
                  ),
                ],
              ),
              Expanded(child: picker),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDate() {
    HapticFeedback.lightImpact();
    DateTime temp = selectedDate;
    final now = DateTime.now();

    _showWheelSheet(
      picker: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: selectedDate,
        minimumDate: DateTime(now.year, now.month, now.day),
        maximumYear: 2100,
        onDateTimeChanged: (value) => temp = value,
      ),
      onDone: () => setState(() => selectedDate = temp),
    );
  }

  void _pickTime() {
    HapticFeedback.lightImpact();
    TimeOfDay temp = selectedTime;

    _showWheelSheet(
      picker: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        use24hFormat: false,
        initialDateTime: DateTime(
          2000,
          1,
          1,
          selectedTime.hour,
          selectedTime.minute,
        ),
        onDateTimeChanged: (value) => temp = TimeOfDay.fromDateTime(value),
      ),
      onDone: () => setState(() => selectedTime = temp),
    );
  }

  Widget _pickerBox({
    required IconData icon,
    required String text,
    required FontWeight weight,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        height: 52,
        width: 169,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 6),
              spreadRadius: 0,
              blurRadius: 20,
              color: const Color(0xff1A0D4D).withAlpha(21),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).secondaryHeaderColor,
        ),
        child: Row(
          spacing: 8,
          children: [
            Icon(icon, color: AppColors.highlight),
            Text(
              text,
              style: TextStyle(
                fontWeight: weight,
                fontSize: 14,
                color: Theme.of(context).highlightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('MMM d, y').format(selectedDate);
    final time = DateFormat(
      'hh:mm a',
    ).format(DateTime(2000, 1, 1, selectedTime.hour, selectedTime.minute));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: .start,
              spacing: 12,
              mainAxisAlignment: .start,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: .center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 22,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                    ),
                    Text(
                      "New task",
                      style: Theme.of(context).primaryTextTheme.titleLarge,
                    ),
                  ],
                ),

                Text(
                  "Title",
                  textAlign: .left,
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),
                TextField(
                  controller: title,
                  style: Theme.of(
                    context,
                  ).primaryTextTheme.titleMedium!.copyWith(fontSize: 15),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(16),
                    fillColor: Theme.of(context).secondaryHeaderColor,
                    filled: true,
                    hint: Text(
                      "Add Title",
                      style: Theme.of(context).primaryTextTheme.titleMedium!
                          .copyWith(
                            fontWeight: .w400,
                            color: const Color(0xff6E6B7B),
                          ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  "Description",
                  textAlign: .left,
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),
                SizedBox(
                  height: 88,
                  child: TextField(
                    controller: des,
                    expands: true,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.top,
                    style: Theme.of(
                      context,
                    ).primaryTextTheme.titleMedium!.copyWith(fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16),
                      fillColor: Theme.of(context).secondaryHeaderColor,
                      filled: true,
                      hint: Text(
                        "Add details (optional)",
                        style: Theme.of(context).primaryTextTheme.titleMedium!
                            .copyWith(
                              fontWeight: .w400,
                              color: const Color(0xff6E6B7B),
                            ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),
                Text(
                  "Date and time",
                  textAlign: .left,
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),

                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    _pickerBox(
                      icon: Icons.calendar_month,
                      text: date,
                      weight: .w600,
                      onTap: _pickDate,
                    ),
                    _pickerBox(
                      icon: Icons.watch_later_outlined,
                      text: time,
                      weight: .bold,
                      onTap: _pickTime,
                    ),
                  ],
                ),
                Text(
                  "Priority",
                  textAlign: .left,
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),

                Center(
                  child: Container(
                    height: 50,
                    width: 350,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 6),
                          blurRadius: 20,
                          color: Color(0xff1A0D4D).withAlpha(22),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ...List.generate(prority.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              alignment: .center,
                              height: 42,
                              width: 111,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: (index == selectedIndex)
                                    ? prority[index]["color"].withAlpha(60)
                                    : Theme.of(context).secondaryHeaderColor,
                              ),

                              child: Text(
                                prority[index]["name"],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: 14,
                                      color: (index == selectedIndex)
                                          ? prority[index]["color"]
                                          : Theme.of(context).highlightColor,
                                    ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                Text(
                  "Category",
                  textAlign: .left,
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),
                Wrap(
                  spacing: 6,
                  children: [
                    ...List.generate(categories.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          height: 40,
                          width: 111,
                          alignment: .center,
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: (index == selectedCategory)
                                ? AppColors.highlight2
                                : Theme.of(context).secondaryHeaderColor,
                          ),
                          child: Row(
                            mainAxisAlignment: .spaceAround,
                            children: [
                              Icon(
                                categories[index]["icon"],
                                size: 16,
                                color: Theme.of(context).highlightColor,
                              ),
                              Text(
                                categories[index]["title"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: .bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () async {
              final t = title.text.trim();
              if (t.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a title')),
                );
                return;
              }

              await insertTask(
                time: time,
                date: date,
                priority: selectedIndex,
                category: categories[selectedCategory]["title"],
                title: t,
                des: des.text.trim(),
              );

              if (!mounted) return;
              Navigator.of(context).pop();
            },
            height: 56,
            minWidth: 350,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            color: AppColors.highlight,
            child: Text(
              "Save task",
              style: TextStyle(
                fontSize: 16,
                fontWeight: .bold,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
