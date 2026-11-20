import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasky/core/db/sqldb.dart';
import 'package:tasky/core/routes/app_routes.dart';
import 'package:tasky/core/themes/app_colors.dart';
import 'package:tasky/core/widget/task_card.dart';

class Claendar extends StatefulWidget {
  const Claendar({super.key});

  @override
  State<Claendar> createState() => _ClaendarState();
}

class _ClaendarState extends State<Claendar> {
  DateTime currentMonth = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String get selectedDateString =>
      DateFormat('EEEE, d MMMM', 'en_US').format(selectedDate);
  Set<int> eventDays = {};
  final Sqldb sqldb = Sqldb();
  bool isLoading = true;
  List<Map> tasks = [];
  String get databaseDate =>
      DateFormat('MMM d, yyyy', 'en_US').format(selectedDate);
  Future<void> loadTasks() async {
    setState(() {
      isLoading = true;
    });

    try {
      final databaseDate = DateFormat(
        'MMM d, yyyy',
        'en_US',
      ).format(selectedDate);

      final data = await sqldb.selectData(
        "SELECT * FROM tasks WHERE date = '$databaseDate'",
      );

      debugPrint('Selected Date: $databaseDate');
      debugPrint('Tasks: $data');

      if (!mounted) return;

      setState(() {
        tasks = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Load Tasks Error: $e');

      if (!mounted) return;

      setState(() {
        tasks = [];
        isLoading = false;
      });
    }
  }

  bool isLoadingEvents = false;
  final List<String> weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  String get monthName {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[currentMonth.month - 1]} ${currentMonth.year}';
  }

  int get daysInMonth {
    return DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
  }

  int get firstDayOffset {
    return DateTime(currentMonth.year, currentMonth.month, 1).weekday - 1;
  }

  bool isSelected(int day) {
    return selectedDate.year == currentMonth.year &&
        selectedDate.month == currentMonth.month &&
        selectedDate.day == day;
  }

  void changeMonth(int value) {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + value);

      eventDays = {};
    });

    loadEventDays();
  }

  @override
  void initState() {
    loadEventDays();
    loadTasks();
    super.initState();
  }

  Future<Set<int>> getEventDaysForMonth(int year, int month) async {
    final Database? mydb = await sqldb.db;

    if (mydb == null) return {};

    final response = await mydb.rawQuery('''
    SELECT DISTINCT date
    FROM tasks
    WHERE date IS NOT NULL
      AND date != ''
    ''');

    final days = <int>{};

    for (final row in response) {
      final dateString = row['date'].toString();

      try {
        final date = DateFormat(
          'MMM dd, yyyy',
          'en_US',
        ).parseStrict(dateString);

        if (date.year == year && date.month == month) {
          days.add(date.day);
        }
      } catch (e) {
        debugPrint('Invalid date: $dateString');
      }
    }

    debugPrint('Event Days: $days');

    return days;
  }

  Future<void> loadEventDays() async {
    setState(() {
      isLoadingEvents = true;
    });

    try {
      final days = await getEventDaysForMonth(
        currentMonth.year,
        currentMonth.month,
      );

      if (!mounted) return;

      setState(() {
        eventDays = days;
        isLoadingEvents = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        eventDays = {};
        isLoadingEvents = false;
      });

      debugPrint('Error loading event days: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalCells = ((firstDayOffset + daysInMonth + 6) ~/ 7) * 7;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    monthName,
                    style: Theme.of(
                      context,
                    ).primaryTextTheme.titleLarge!.copyWith(fontSize: 24),
                  ),

                  Row(
                    children: [
                      _monthButton(
                        icon: Icons.chevron_left,
                        onTap: () => changeMonth(-1),
                      ),
                      const SizedBox(width: 8),
                      _monthButton(
                        icon: Icons.chevron_right,
                        onTap: () => changeMonth(1),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Container(
                height: 340,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff1A0D4D).withAlpha(16),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Week Days
                    SizedBox(
                      height: 30,
                      child: Row(
                        children: weekDays.map((day) {
                          return Expanded(
                            child: Center(
                              child: Text(
                                day,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF858594),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: totalCells,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              childAspectRatio: 0.85,
                            ),
                        itemBuilder: (context, index) {
                          final day = index - firstDayOffset + 1;

                          if (day < 1 || day > daysInMonth) {
                            return const SizedBox();
                          }

                          final selected = isSelected(day);
                          final hasEvent = eventDays.contains(day);

                          return InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              setState(() {
                                selectedDate = DateTime(
                                  currentMonth.year,
                                  currentMonth.month,
                                  day,
                                );
                              });

                              loadTasks();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Day Number
                                Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? AppColors.highlight
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Text(
                                    '$day',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: selected
                                          ? Theme.of(
                                              context,
                                            ).secondaryHeaderColor
                                          : Theme.of(context).highlightColor,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 3),

                                Container(
                                  height: 6,
                                  width: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: hasEvent
                                        ? AppColors.highlight
                                        : Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Text(
                selectedDateString,
                style: Theme.of(context).primaryTextTheme.titleMedium,
              ),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (tasks.isEmpty)
                const Text('No tasks yet')
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final t = tasks[index];
                    return TaskCard(
                      key: ValueKey(t["id"]),
                      id: t["id"],
                      priorityId: t["priority"],
                      title: t["task"],
                      category: t["category"],
                      time: t["time"],
                      isdone: t["is_done"],
                    );
                  },
                ),
            ],
          ),
        ),
      ),

      floatingActionButton: SizedBox(
        height: 64,
        width: 64,
        child: FloatingActionButton.large(
          backgroundColor: AppColors.highlight,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () async {
            HapticFeedback.mediumImpact();

            //  await Navigator.of(context).pushNamed(AppRoutes.addTask);
            context.go(AppRoutes.addTask);
            if (!mounted) return;

            loadTasks();
            loadEventDays();
          },
          child: Icon(Icons.add, size: 32, color: AppColors.white),
        ),
      ),
    );
  }

  Widget _monthButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, size: 23, color: Theme.of(context).highlightColor),
      ),
    );
  }
}
