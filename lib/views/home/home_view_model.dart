import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
// import 'package:uuid/uuid.dart';

class HomeViewModel extends BaseViewModel {
  Logger log;
  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  NavigationService _navigationService = locator<NavigationService>();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  PageController pageController = PageController(initialPage: 0);
  String _title = 'Today';
  get title => _title;

  // var uuid = Uuid();

  void updateTitle() {
    switch (_selectedIndex) {
      case 0:
        _title = 'Today';
        break;
      case 1:
        _title = 'Social';
        break;
      case 2:
        _title = 'Discover';
        break;
      case 3:
        _title = 'Profile';
        break;
      default:
    }
  }

  // * For The BottomNavigationBar(onTap)
  void updateSelectedNavbarItem(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      updateTitle();
      pageController.animateToPage(
        _selectedIndex,
        curve: Curves.easeInOutQuart,
        duration: Duration(milliseconds: 500),
      );
    } else {
      print('you are on the same page !!');
    }
    notifyListeners();
  }

  // * For sliding the PageView(onPageChanged)
  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    updateTitle();
    notifyListeners();
  }

  void logout() {
    _authService.logout();
    _navigationService.pushNamedAndRemoveUntil(authpageViewRoute);
  }

  TaskService _taskService = locator<TaskService>();
  AuthService _authService = locator<AuthService>();
  void addTask() async {
    String id = UniqueKey().toString();
    // String id = uuid.v4();
    Task task = Task(
        public: false,
        checked: false,
        lable: 'A task to be done',
        due: DateTime.now(),
        category: 'Work',
        id: id);
    _taskService.addTask(task);
    notifyListeners();
    print(_taskService.rxTaskList.length);
    print(id);
  }
}
