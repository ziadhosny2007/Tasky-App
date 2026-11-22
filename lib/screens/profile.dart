
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/db/sqldb.dart';
import 'package:tasky/core/themes/app_colors.dart';
import 'package:tasky/generated/l10n.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final SharedPreferencesAsync sharedPreferencesAsync =
      SharedPreferencesAsync();

  bool isDark = false;
  bool isAr = false;
  String selectedLanguage = "English";

  int totalTasks = 0;
  int complatedTasks = 0;
  int pendingTasks = 0;

  @override
  void initState() {
    super.initState();
    loadPreferences();
    loadData();
  }

  // Load saved preferences
  Future<void> loadPreferences() async {
    final dark = await sharedPreferencesAsync.getBool("isDark") ?? false;
    final arabic = await sharedPreferencesAsync.getBool("isAr") ?? false;

    if (!mounted) return;

    setState(() {
      isDark = dark;
      isAr = arabic;
      selectedLanguage = isAr ? "العربية" : "English";
    });
  }

  // Load tasks statistics
  Future<void> loadData() async {
    Sqldb db = Sqldb();

    List<Map> data = await db.selectData("SELECT * FROM tasks");

    int total = data.length;
    int completed =
        data.where((e) => e["is_done"] == 1).length;
    int pending =
        data.where((e) => e["is_done"] == 0).length;

    if (!mounted) return;

    setState(() {
      totalTasks = total;
      complatedTasks = completed;
      pendingTasks = pending;
    });
  }

  // Change dark mode
  Future<void> changeDarkMode(bool value) async {
    await sharedPreferencesAsync.setBool("isDark", value);

    if (!mounted) return;

    setState(() {
      isDark = value;
    });
  }

  // Change language
  Future<void> changeLanguage(bool arabic) async {
    await sharedPreferencesAsync.setBool("isAr", arabic);

    if (!mounted) return;

    setState(() {
      isAr = arabic;
      selectedLanguage = arabic ? "العربية" : "English";
    });

    Navigator.pop(context);
  }

  // Language bottom sheet
  void showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Text(
                  "Select Language",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).highlightColor,
                  ),
                ),

                ListTile(
                  title: const Text("English"),
                  trailing: !isAr
                      ? Icon(Icons.check, color: AppColors.highlight)
                      : null,
                  onTap: () async {
                    await changeLanguage(false);
                  },
                ),

                ListTile(
                  title: const Text("العربية"),
                  trailing: isAr
                      ? Icon(Icons.check, color: AppColors.highlight)
                      : null,
                  onTap: () async {
                    await changeLanguage(true);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          // Main ListView
          child: ListView(
            children: [

              // Profile title
              Text(
                l10n.navProfile,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).highlightColor,
                ),
              ),

              const SizedBox(height: 20),

              // Profile information
              Column(
                spacing: 3,
                children: [
                  Center(
                    child: Container(
                      height: 96,
                      width: 96,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff6C4CF1),
                            Color(0xff2A1B6B),
                          ],
                        ),
                      ),
                      child: const Text(
                        "Z",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Text(
                    "Ziad Hosny",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),

                  const Text(
                    "ziadhosny740@gmail.com",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
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
                      color: const Color(0xffEEEAFE),
                      height: 35,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 9,
                      ),
                      child: Text(
                        l10n.editProfile,
                        style: TextStyle(
                          color: AppColors.highlight,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Tasks statistics
              Container(
                width: double.infinity,
                height: 92,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 12,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff6C4CF1),
                      Color(0xff2A1B6B),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Total tasks
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "$totalTasks",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          l10n.totalTasks,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white.withAlpha(180),
                          ),
                        ),
                      ],
                    ),

                    // Completed tasks
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "$complatedTasks",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color(0xff3DBE8B),
                          ),
                        ),
                        Text(
                          l10n.profileCompleted,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white.withAlpha(180),
                          ),
                        ),
                      ],
                    ),

                    // Pending tasks
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "$pendingTasks",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color(0xffF5A524),
                          ),
                        ),
                        Text(
                          l10n.profilePending,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white.withAlpha(180),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Preferences title
              Text(
                l10n.preferences,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Theme.of(context).highlightColor,
                ),
              ),

              const SizedBox(height: 10),

              // Dark mode
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,

                  leading: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffEEEAFE),
                    ),
                    child: Icon(
                      Icons.wb_sunny,
                      color: AppColors.highlight,
                    ),
                  ),

                  title: Text(
                    l10n.darkMode,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),

                  trailing: Switch(
                    value: isDark,
                    onChanged: changeDarkMode,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Language
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,

                  leading: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffEEEAFE),
                    ),
                    child: Icon(
                      Icons.language,
                      color: AppColors.highlight,
                    ),
                  ),

                  title: Text(
                    l10n.language,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).highlightColor,
                    ),
                  ),

                  trailing: TextButton(
                    onPressed: showLanguageSheet,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(selectedLanguage),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
