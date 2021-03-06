import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  Logger log;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  NavigationService _navigationService = locator<NavigationService>();
  AuthService _authService = locator<AuthService>();

  LoginViewModel() {
    log = getLogger(this.runtimeType.toString());
  }
  void toggleIsLodaing() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void signinWithEmail() async {
    if (emailController.text == '' || passwordController.text == '') {
      _snackbarService.showSnackbar(message: 'Please fill the required fields');
    } else {
      toggleIsLodaing();

      final result = await _authService.signinWithEmail(
          email: emailController.text, password: passwordController.text);

      if (result.hasError) {
        toggleIsLodaing();
        _dialogService.showDialog(
          barrierDismissible: true,
          title: 'Error',
          description: result.errorMessage,
        );
      } else {
        toggleIsLodaing();
        print('Auth sign in with email');
        print('Result uid: ${result.uid}');

        _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
      }
    }
  }

  // TODO: Implement forgotPassword
  void forgotPassword() {}

  // TODO: Implement authWithGoogle
  void authWithGoogle() {}

  // TODO: Implement authWithApple
  void authWithApple() {}
}
