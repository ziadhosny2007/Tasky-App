import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tasky/core/db/sqldb.dart';
import 'package:tasky/core/routes/app_routes.dart';
import 'package:tasky/core/themes/app_colors.dart';
import 'package:tasky/core/widget/task_card.dart';
import 'package:tasky/generated/l10n.dart';

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
  }

  final date = DateFormat('MMM d, y', 'en').format(DateTime.now());

  Future<void> loadTasks() async {
    final data = await db.selectData(
      "SELECT * FROM tasks WHERE date = '$date'",
    );
    if (!mounted) return;
    setState(() {
      tasks = data;
      isLoading = false;
    });
  }

  List<dynamic> get completedTasks => tasks.where((e) => e["is_done"] == 1).toList();
  List<dynamic> get numOfWorkTasks => tasks
      .where((e) => e["category"] == "Work")
      .toList();
  List<dynamic> get numOfPersonalTasks => tasks
      .where((e) => e["category"] == "Personal")
      .toList();
  List<dynamic> get numOfShoppingTasks => tasks
      .where((e) => e["category"] == "Shopping")
      .toList();
  List<dynamic> get numOfHealthTasks => tasks
      .where((e) => e["category"] == "Health")
      .toList();

  List<Map<dynamic, dynamic>> get categories => [
    {"icon": Icons.work, "title": "Work", "tasks": numOfWorkTasks.length},
    {
      "icon": Icons.person,
      "title": "Personal",
      "tasks": numOfPersonalTasks.length,
    },
    {
      "icon": Icons.shopping_bag_outlined,
      "title": "Shopping",
      "tasks": numOfShoppingTasks.length,
    },
    {
      "icon": Icons.favorite_border_outlined,
      "title": "Health",
      "tasks": numOfHealthTasks.length,
    },
  ];

  double get progress {
    if (tasks.isEmpty) return 0;
    final done = tasks.where((e) => e["is_done"] == 1).length;
    return done / tasks.length;
  }

  List<bool> presed = [false, false, false, false];
  int? selectedCategory;
  List<Map> get filteredTasks {
    if (selectedCategory == null) return tasks;
    final cat = categories[selectedCategory!]["title"];
    return tasks.where((e) => e["category"] == cat).toList();
  }

  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final locale = Localizations.localeOf(context).toString();
    final categoryNames = [
      l10n.categoryWork,
      l10n.categoryPersonal,
      l10n.categoryShopping,
      l10n.categoryHealth,
    ];
    final now = DateTime.now();
    final dayNumber = DateFormat('d', locale).format(now);
    final dayName = DateFormat('EEEE', locale).format(now);
    final monthName = DateFormat('MMMM', locale).format(now);

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
                    l10n.homeTitle,
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
                                l10n.todaysProgress,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: .bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Text(
                                (tasks.length != 0)
                                    ? l10n.tasksCompletedOf(
                                        completedTasks.length,
                                        tasks.length,
                                      )
                                    : l10n.noTasksToday,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: .w400,
                                  color: Color(0xffffffff).withAlpha(120),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: progress),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOut,

                          builder: (context, v, _) {
                            loadTasks();
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 72,
                                  height: 72,
                                  child: CircularProgressIndicator(
                                    value: v,
                                    strokeWidth: 7,
                                    strokeCap: StrokeCap.round,
                                    backgroundColor: Colors.white24,
                                    valueColor: AlwaysStoppedAnimation(
                                      AppColors.highlight2,
                                    ),
                                  ),
                                ),
                                Text(
                                  NumberFormat.percentPattern(locale).format(v),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  l10n.categories,
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
                                  loadTasks();
                                  setState(() {
                                    selectedCategory =
                                        (selectedCategory == index)
                                        ? null
                                        : index;
                                  });
                                },
                                child: AnimatedScale(
                                  scale: presed[index] ? 0.90 : 1,
                                  duration: Duration(milliseconds: 100),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: EdgeInsets.all(0),
                                    elevation: (selectedCategory == index)
                                        ? 2
                                        : .5,
                                    child: Container(
                                      alignment: .topLeft,
                                      width: 80,
                                      height: 86,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: (selectedCategory == index)
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
                                            color: (selectedCategory == index)
                                                ? AppColors.dark
                                                : AppColors.highlight,
                                          ),
                                          Text(
                                            categoryNames[index],
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color:
                                                      (selectedCategory ==
                                                          index)
                                                      ? AppColors.dark
                                                      : Theme.of(
                                                          context,
                                                        ).highlightColor,
                                                ),
                                          ),
                                          Text(
                                            l10n.tasksCount(
                                              categories[index]["tasks"],
                                            ),
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .titleSmall!
                                                .copyWith(
                                                  fontSize: 10,
                                                  color:
                                                      (selectedCategory ==
                                                          index)
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
                  l10n.todaysTasks,
                  style: Theme.of(context).primaryTextTheme.titleMedium,
                ),
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (filteredTasks.isEmpty)
                  Text(l10n.noTasksYet)
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final t = filteredTasks[index];
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
            loadTasks();
          },
          child: Icon(Icons.add, size: 32, color: AppColors.white),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable