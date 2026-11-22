// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Taskly`
  String get appName {
    return Intl.message('Taskly', name: 'appName', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Get started`
  String get getStarted {
    return Intl.message('Get started', name: 'getStarted', desc: '', args: []);
  }

  /// `Keep every task in its place`
  String get onboarding1Title {
    return Intl.message(
      'Keep every task in its place',
      name: 'onboarding1Title',
      desc: '',
      args: [],
    );
  }

  /// `Sort your to-dos into Work, Personal, Shopping and Health so nothing gets lost.`
  String get onboarding1Body {
    return Intl.message(
      'Sort your to-dos into Work, Personal, Shopping and Health so nothing gets lost.',
      name: 'onboarding1Body',
      desc: '',
      args: [],
    );
  }

  /// `Focus on what matters`
  String get onboarding2Title {
    return Intl.message(
      'Focus on what matters',
      name: 'onboarding2Title',
      desc: '',
      args: [],
    );
  }

  /// `Mark tasks Low, Medium or High and start your day with the ones that count.`
  String get onboarding2Body {
    return Intl.message(
      'Mark tasks Low, Medium or High and start your day with the ones that count.',
      name: 'onboarding2Body',
      desc: '',
      args: [],
    );
  }

  /// `See your progress grow`
  String get onboarding3Title {
    return Intl.message(
      'See your progress grow',
      name: 'onboarding3Title',
      desc: '',
      args: [],
    );
  }

  /// `Watch your daily progress fill up and build a habit of finishing.`
  String get onboarding3Body {
    return Intl.message(
      'Watch your daily progress fill up and build a habit of finishing.',
      name: 'onboarding3Body',
      desc: '',
      args: [],
    );
  }

  /// `What do you want to do today?`
  String get homeTitle {
    return Intl.message(
      'What do you want to do today?',
      name: 'homeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Today’s progress`
  String get todaysProgress {
    return Intl.message(
      'Today’s progress',
      name: 'todaysProgress',
      desc: '',
      args: [],
    );
  }

  /// `{total, plural, =1{{completed} of 1 task completed} other{{completed} of {total} tasks completed}}`
  String tasksCompletedOf(int completed, int total) {
    return Intl.plural(
      total,
      one: '$completed of 1 task completed',
      other: '$completed of $total tasks completed',
      name: 'tasksCompletedOf',
      desc: '',
      args: [completed, total],
    );
  }

  /// `{value}`
  String progressPercent(double value) {
    final NumberFormat valueNumberFormat = NumberFormat.percentPattern(
      Intl.getCurrentLocale(),
    );
    final String valueString = valueNumberFormat.format(value);

    return Intl.message(
      '$valueString',
      name: 'progressPercent',
      desc: 'Progress ring label. Pass a double between 0 and 1, e.g. 0.6 shows 60%',
      args: [valueString],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Today’s tasks`
  String get todaysTasks {
    return Intl.message(
      'Today’s tasks',
      name: 'todaysTasks',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =1{1 task} other{{count} tasks}}`
  String tasksCount(int count) {
    return Intl.plural(
      count,
      one: '1 task',
      other: '$count tasks',
      name: 'tasksCount',
      desc: '',
      args: [count],
    );
  }

  /// `{category} • {time}`
  String taskMeta(String category, String time) {
    return Intl.message(
      '$category • $time',
      name: 'taskMeta',
      desc: 'Sub-line under a task title, e.g. Work • 9:30 AM',
      args: [category, time],
    );
  }

  /// `Work`
  String get categoryWork {
    return Intl.message('Work', name: 'categoryWork', desc: '', args: []);
  }

  /// `Personal`
  String get categoryPersonal {
    return Intl.message(
      'Personal',
      name: 'categoryPersonal',
      desc: '',
      args: [],
    );
  }

  /// `Shopping`
  String get categoryShopping {
    return Intl.message(
      'Shopping',
      name: 'categoryShopping',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get categoryHealth {
    return Intl.message('Health', name: 'categoryHealth', desc: '', args: []);
  }

  /// `Low`
  String get priorityLow {
    return Intl.message('Low', name: 'priorityLow', desc: '', args: []);
  }

  /// `Medium`
  String get priorityMedium {
    return Intl.message('Medium', name: 'priorityMedium', desc: '', args: []);
  }

  /// `High`
  String get priorityHigh {
    return Intl.message('High', name: 'priorityHigh', desc: '', args: []);
  }

  /// `Today`
  String get navToday {
    return Intl.message('Today', name: 'navToday', desc: '', args: []);
  }

  /// `Calendar`
  String get navCalendar {
    return Intl.message('Calendar', name: 'navCalendar', desc: '', args: []);
  }

  /// `Profile`
  String get navProfile {
    return Intl.message('Profile', name: 'navProfile', desc: '', args: []);
  }

  /// `New task`
  String get newTask {
    return Intl.message('New task', name: 'newTask', desc: '', args: []);
  }

  /// `Title`
  String get fieldTitle {
    return Intl.message('Title', name: 'fieldTitle', desc: '', args: []);
  }

  /// `Plan the week`
  String get titleHint {
    return Intl.message('Plan the week', name: 'titleHint', desc: '', args: []);
  }

  /// `Description`
  String get fieldDescription {
    return Intl.message(
      'Description',
      name: 'fieldDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add details (optional)`
  String get descriptionHint {
    return Intl.message(
      'Add details (optional)',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Date and time`
  String get fieldDateTime {
    return Intl.message(
      'Date and time',
      name: 'fieldDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get fieldPriority {
    return Intl.message('Priority', name: 'fieldPriority', desc: '', args: []);
  }

  /// `Category`
  String get fieldCategory {
    return Intl.message('Category', name: 'fieldCategory', desc: '', args: []);
  }

  /// `Save task`
  String get saveTask {
    return Intl.message('Save task', name: 'saveTask', desc: '', args: []);
  }

  /// `Total`
  String get profileTotal {
    return Intl.message('Total', name: 'profileTotal', desc: '', args: []);
  }

  /// `Completed`
  String get profileCompleted {
    return Intl.message(
      'Completed',
      name: 'profileCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get profilePending {
    return Intl.message('Pending', name: 'profilePending', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Dark mode`
  String get darkMode {
    return Intl.message('Dark mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Reminders`
  String get reminders {
    return Intl.message('Reminders', name: 'reminders', desc: '', args: []);
  }

  /// `Clear completed tasks`
  String get clearCompletedTasks {
    return Intl.message(
      'Clear completed tasks',
      name: 'clearCompletedTasks',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Add Title`
  String get addTitle {
    return Intl.message('Add Title', name: 'addTitle', desc: '', args: []);
  }

  /// `Please enter a title`
  String get enterTitleError {
    return Intl.message(
      'Please enter a title',
      name: 'enterTitleError',
      desc: '',
      args: [],
    );
  }

  /// `No tasks yet`
  String get noTasksYet {
    return Intl.message('No tasks yet', name: 'noTasksYet', desc: '', args: []);
  }

  /// `There are no tasks today`
  String get noTasksToday {
    return Intl.message(
      'There are no tasks today',
      name: 'noTasksToday',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get editProfile {
    return Intl.message(
      'Edit profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Total tasks`
  String get totalTasks {
    return Intl.message('Total tasks', name: 'totalTasks', desc: '', args: []);
  }

  /// `Preferences`
  String get preferences {
    return Intl.message('Preferences', name: 'preferences', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
