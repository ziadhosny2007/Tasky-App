import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/db/sqldb.dart';
import 'package:tasky/core/themes/app_colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SharedPreferencesAsync sharedPreferencesAsync = SharedPreferencesAsync();
  bool isDark = false;
  void flage() async {
    isDark = await sharedPreferencesAsync.getBool("isDark") ?? false;
    setState(() {});
  }

  int totalTasks = 0;
  int complatedTasks = 0;
  int pendingTasks = 0;

  Future loadData() async {
    Sqldb db = Sqldb();
    List<Map> data = await db.selectData("Select *From tasks");
    totalTasks = data.length;
    complatedTasks = data.where((e) => e["is_done"] == 1).toList().length;
    pendingTasks = data.where((e) => e["is_done"] == 0).toList().length;
  }

  @override
  void initState() {
    flage();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: .bold,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                  Column(
                    spacing: 3,
                    children: [
                      Center(
                        child: Container(
                          height: 96,
                          width: 96,
                          alignment: .center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            gradient: LinearGradient(
                              begin: AlignmentGeometry.topLeft,
                              end: AlignmentGeometry.bottomRight,
                              colors: [Color(0xff6C4CF1), Color(0xff2A1B6B)],
                            ),
                          ),
                          child: Text(
                            "Z",
                            style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 38,
                              fontWeight: .bold,
                            ),
                          ),
                        ),
                      ), //ziadhosny740@gmail.com
                      Text(
                        "Ziad Hosny",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: .bold,
                          color: Theme.of(context).highlightColor,
                        ),
                      ),
                      Text(
                        "ziadhosny740@gmail.com",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: .w700,
                          color: Color(0xff6E6B7B),
                        ),
                      ),
                      SizedBox(
                        width: 114,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {},
                          color: Color(0xffEEEAFE),
                          height: 35,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 9,
                          ),
                          child: Text(
                            "Edit profile",
                            style: TextStyle(
                              color: AppColors.highlight,
                              fontWeight: .w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 92,
                    width: 350,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 28),
                    alignment: .center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: LinearGradient(
                        begin: AlignmentGeometry.topLeft,
                        end: AlignmentGeometry.bottomRight,
                        colors: [Color(0xff6C4CF1), Color(0xff2A1B6B)],
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: .spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "$totalTasks",
                              style: TextStyle(
                                fontWeight: .bold,
                                fontSize: 26,
                                color: AppColors.white,
                              ),
                            ),
                            Text(
                              "Total tasks",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: .w400,
                                color: AppColors.white.withAlpha(180),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "$complatedTasks",
                              style: TextStyle(
                                fontWeight: .bold,
                                fontSize: 26,
                                color: Color(0xff3DBE8B),
                              ),
                            ),
                            Text(
                              "Completed",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: .w400,
                                color: AppColors.white.withAlpha(180),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "$pendingTasks",
                              style: TextStyle(
                                fontWeight: .bold,
                                fontSize: 26,
                                color: Color(0xffF5A524),
                              ),
                            ),
                            Text(
                              "Pending",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: .w400,
                                color: AppColors.white.withAlpha(180),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Preferences",
                    style: TextStyle(
                      fontWeight: .w600,
                      fontSize: 16,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      spacing: 1,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          alignment: .center,
                          child: ListTile(
                            leading: Container(
                              height: 40,
                              width: 40,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0xffEEEAFE),
                              ),
                              child: Icon(
                                Icons.wb_sunny,
                                color: AppColors.highlight,
                              ),
                            ),
                            title: Text(
                              "Dark mode",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: .w700,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                            trailing: Switch(
                              value: isDark,
                              onChanged: (value) async {
                                await sharedPreferencesAsync.setBool(
                                  "isDark",
                                  value,
                                );
                                isDark = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
