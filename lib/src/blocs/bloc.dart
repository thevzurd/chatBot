import 'dart:async';
// We are creating two stream controllers for email and password
// When an event occurs, inthis case, change in the text field, the
// data is added to the sink. From the sink only the information that
// we want is passed to the stream. The transformer validates the data in the
// stream and returns error or processed information
import 'package:rxdart/rxdart.dart';
// class Bloc with Validators { - This will not work as the mixins can only be used when 'extends is used
// extends is usually for the base class and Bloc is your sub class. So to prevent the error, as we dont have
// any base classes here, we can either say Bloc extends Validators or use the Dart base class called Object as follows.
class Bloc extends Object with Validators {
  final chats = List<String>();
  // two instance variables for BLOC controller
  // Adding _ in front of a variable makes it PRIVATE
  final _chat = BehaviorSubject<String>(); // we are only expecting strings
// Getter will help you get the property of the class without having to list the entire thing
// You can reference changeEmail from anywhere are get the value of the property
// Retrieve data from stream  - annotated as a function that accepts a string
  Function(String) get retrieveChat => _chat.sink.add; 
// Add data from stream - annotated to accept String
// When you get the input, you return a transformed string, well if you want to 
  Stream<String> get newChat => _chat.stream.transform(validateChat);

  submit() {
    chats.add(_chat.value); // last value that flowed through the stream
    print(chats.toString());
  }
// Any time a stream controller is open, it comes with a sink, which is open
// it needs to be closed at the end.
dispose() {
  _chat.close();
}
}

// Transformer validates the data and adds to the stream
class Validators {
  // Notice that the input and the output of the Transformer has been explicitly mentioned
  // This corresponds to email and sink variables in the handleData
  final validateChat = StreamTransformer<String, String>.fromHandlers(
    handleData: (chat, sink) {
      if (chat.isNotEmpty) {
        sink.add(chat);
      }
      else { //errors ? //
      }
    }
  );
}
// This is to create one instance of block consistent across the application
// good for smaller apps.
final bloc = new Bloc();
// For larger applications, we use a scoped instance.
