part of 'app_section_cubit.dart';

sealed class AppSectionState {
  const AppSectionState(this.index);
  final int index;
}

final class HomePage extends AppSectionState {
  const HomePage() : super(0);
}

final class CalendarPage extends AppSectionState {
  const CalendarPage() : super(1);
}

final class ProfilePage extends AppSectionState {
  const ProfilePage() : super(2);
}