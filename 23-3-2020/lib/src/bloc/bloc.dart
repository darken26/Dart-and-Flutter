import 'dart:async';
import 'validator.dart';

class Bloc with Validators{
  final _email = StreamController<String>();
  final _password = StreamController<String>();

  // add data to stream
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);

  // change data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  dispose() {
    _email.close();
    _password.close();
  }
}