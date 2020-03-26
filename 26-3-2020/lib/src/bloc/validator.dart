import 'dart:async';

class Validators {
  final emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if(email.contains('@')){
        sink.add(email);
      } else {
        sink.addError('email is not valid');
      }
    }
  );

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length > 3){
        sink.add(password);
      } else {
        sink.addError('password must at least 4 character, ${4 - password.length} remaining!');
      }
    }
  );
}