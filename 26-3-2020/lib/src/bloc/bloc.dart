import 'dart:async';
import 'validator.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators{
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  // add data to stream
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (e, p) => true);

  // change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  submit() {
    final emailValue = _email.value;
    final passwordValue = _password.value;

    print("email is $emailValue");
    print("password is $passwordValue");
  }

  dispose() {
    _email.close();
    _password.close();
  }
}