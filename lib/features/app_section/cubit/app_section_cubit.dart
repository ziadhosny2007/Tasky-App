import 'package:bloc/bloc.dart';

part 'app_section_state.dart';

class AppSectionCubit extends Cubit<AppSectionState> {
  AppSectionCubit() : super(HomePage());

  void getIndex(int index) {
    switch (index) {
      case 0:
        emit(HomePage());
        break;
      case 1:
        emit(CalendarPage());
        break;
      case 2:
        emit(ProfilePage());
    }
  }
}
