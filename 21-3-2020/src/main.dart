import 'dart:html';
import 'dart:async';

void main() {
  final InputElement input = querySelector('input');
  final DivElement div = querySelector('div');
  
  
  final checkValidate = StreamTransformer.fromHandlers(
    handleData: (inputValue, sink){
      if(inputValue.contains('@'))
        sink.add('is valid');
      else
        sink.addError('your email is not valid');
    }
  );
  
  input.onInput
    .map((dynamic event) => event.target.value)
    .transform(checkValidate)
    .listen(
      (value) => div.innerHtml = '',
      onError: (value) => div.innerHtml = value
    );
 
}
