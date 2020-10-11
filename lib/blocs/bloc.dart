import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  ///**
  /// * Add data to stream.
  ///*/
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  ///
  ///* Retireve data from stream.
  //*/
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (email, password) => true);

// User 1: 9898989898 / password123
// User 2: 9876543210 / password123
  bool checkUserData() {
    List<String> myUser = ['9898989898', '9876543210'];
    bool isValidData = false;
    final validEmail = this._emailController.value;
    final validPassword = this._passwordController.value;
    if (myUser.contains(validEmail) && validPassword == 'password123') {
      isValidData = true;
    }

    print('Email is $validEmail');
    print('Password is $validPassword');

    return isValidData;
  }

  ///**
  ///   * Close the stream.
  ///   *
  ///   * @return {void}
  ///   */
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
