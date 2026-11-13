import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tasky/core/db/sqldb.dart';
import 'package:tasky/core/routes/app_routes.dart';
import 'package:tasky/core/themes/app_colors.dart';
import 'package:tasky/core/widget/task_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Sqldb db = Sqldb();
  List<Map> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadTasks();
    loading(.6);
  }

  Future<void> loadTasks() async {
    final data = await db.selectData('SELECT * FROM tasks');
    if (!mounted) return;
    setState(() {
      tasks = data;
      isLoading = false;
    });
  }

  List<Map> categories = [
    {"icon": Icons.work, "title": "Work", "tasks": 3},
    {"icon": Icons.person, "title": "Personal", "tasks": 4},
    {"icon": Icons.shopping_bag_outlined, "title": "Shopping", "tasks": 1},
    {"icon": Icons.favorite_border_outlined, "title": "Health", "tasks": 2},
  ];

  double value = .0;
  void loading(double v) async {
    double n = v / 10;
    value = n;
    while (v > value) {
      await Future.delayed(Duration(milliseconds: 50), () {
        value += n;
        setState(() {});
      });
    }
  }

  List<bool> presed = [false, false, false, false];
  List<bool> flage = [false, false, false, false];
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dayNumber = DateFormat('d').format(now);
    final dayName = DateFormat('EEEE').format(now);
    final monthName = DateFormat('MMMM').format(now);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: .start,
              spacing: 6,
              children: [
                Row(
                  children: [
                    Text(
                      dayName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: .w400,
                        color: Color(0xff6E6B7B),
                      ),
                    ),
                    Text(
                      ",$monthName ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: .w400,
                        color: Color(0xff6E6B7B),
                      ),
                    ),
                    Text(
                      dayNumber,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: .w400,
                        color: Color(0xff6E6B7B),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  width: 248,
                  child: Text(
                    "What do you want to do today?",
                    style: Theme.of(
                      context,
                    ).primaryTextTheme.titleLarge!.copyWith(fontSize: 28),
                  ),
                ),
                Center(
                  child: Container(
                    alignment: .center,
                    padding: EdgeInsets.all(22),
                    width: 350,
                    height: 116,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),

                      gradient: LinearGradient(
                        colors: [Color(0xff6C4CF1), Color(0xff2A1B6B)],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Column(
                            children: [
                              Text(
                                "Today’s progress",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: .bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Text(
                                "3 of 5 tasks completed",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: .w400,
                                  color: Color(0xffffffff).withAlpha(120),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 72,
                              height: 72,
                              child: CircularProgressIndicator(
                                value: value,
                                strokeWidth: 7,
                                strokeCap: StrokeCap.round, // أطراف مدورة
                                backgroundColor: Colors.white24,
                                valueColor: AlwaysStoppedAnimation(
                                  AppColors.highlight2,
                                ),
                              ),
                            ),
                            Text(
                              '${(value * 100).round()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "Categories",
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: SizedBox(
                      height: 90,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 10,
                          mainAxisAlignment: .spaceEvenly,
                          crossAxisAlignment: .center,
                          children: [
                            ...List.generate(categories.length, (index) {
                              return GestureDetector(
                                onTapDown: (details) => setState(() {
                                  presed[index] = true;
                                }),
                                onTapUp: (details) => setState(() {
                                  presed[index] = false;
                                }),
                                onTapCancel: () => setState(() {
                                  presed[index] = false;
                                }),

                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  flage = flage.map((e) => e = false).toList();
                                  flage[index] = !flage[index];
                                  setState(() {});
                                },
                                child: AnimatedScale(
                                  scale: presed[index] ? 0.90 : 1,
                                  duration: Duration(milliseconds: 100),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: EdgeInsets.all(0),
                                    elevation: (flage[index]) ? 2 : .5,
                                    child: Container(
                                      alignment: .topLeft,
                                      width: 80,
                                      height: 86,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (flage[index])
                                            ? AppColors.highlight2
                                            : Theme.of(
                                                context,
                                              ).secondaryHeaderColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            categories[index]["icon"],
                                            size: 22,
                                            color: (flage[index])
                                                ? AppColors.dark
                                                : AppColors.highlight,
                                          ),
                                          Text(
                                            categories[index]["title"],
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: (flage[index])
                                                      ? AppColors.dark
                                                      : Theme.of(
                                                          context,
                                                        ).highlightColor,
                                                ),
                                          ),
                                          Text(
                                            " ${categories[index]["tasks"]} tasks",
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .titleSmall!
                                                .copyWith(
                                                  fontSize: 10,
                                                  color: (flage[index])
                                                      ? AppColors.dark
                                                      : Theme.of(
                                                          context,
                                                        ).highlightColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Today’s tasks",
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
                        id: t["id"],
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
            await Navigator.of(context).pushNamed(AppRoutes.addTask);
            loadTasks();
          },
          child: Icon(Icons.add, size: 32, color: AppColors.white),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
