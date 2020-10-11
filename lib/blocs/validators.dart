import 'dart:async';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.length >= 3 && email.length <= 10) {
      sink.add(email);
    } else {
      sink.addError('Username must be at least 3 or at most 10 characters.');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 3 && password.length <= 11) {
      sink.add(password);
    } else {
      sink.addError('Password must be at least 3 or at most 10 characters.');
    }
  });
}
