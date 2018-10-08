import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
// Stateful widgets are useful when considering single screen applications
// However, using multiple screens and information transfer between them is 
// complex in Stateful widget. For this purpose we use BLOC or
// Business Logic Component, which exists independent of any widgets in the app
// and can be accessed from anywhere.
// So this time we are creating a  statless Widget
class ChatScreen extends StatelessWidget {
  final textController = new TextEditingController();
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Keep Calm and Bing!'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () { /* Go back where you came from */ },
          ),
        ),
        body: chatBody(),
      );
  }

  Widget chatBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // sticks to the keyboard
      children: <Widget>[
        Expanded(child: conversations(),),
        Container( 
          color: Colors.blue,
          child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.insert_emoticon),
                  color: Colors.white,
                  onPressed: () {},
                ),
                chatInput(),
                IconButton(
                  icon: Icon(Icons.change_history),
                  color: Colors.white,
                  onPressed: () {bloc.retrieveChat(textController.text); bloc.submit();},
                ), 
              ],
            )
          ),
      ]
    );
  } // chatBody Helper

  Widget chatInput() {
    return Expanded( 
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),),
          color: Colors.white,),
        child: chatText(),
        padding: EdgeInsets.only(bottom: 05.0),
      )
    );
  } // chatInput Helper Method

  Widget chatText() {
      return StreamBuilder(
      stream:bloc.newChat, // watching the stream
      builder: (context, snapshot) { // Everytime the input changes
      // the builder function renders the app with the new data
      // snapshot -> whatever value that came across the stream
        return TextField(
          controller: textController,
          decoration: InputDecoration(
                fillColor: Colors.white,
              ),
          keyboardType: TextInputType.multiline,
        );
      }
    );
  } // chatText Helper Method

  Widget conversations() {
    return Container (
      color: Colors.transparent,
      child: ListView.builder(
        itemCount: bloc.chats.length,
        itemBuilder: (context, index) {
          return bubble(bloc.chats[index]);
        },
      ),
    );
  }

  Widget bubble(String chat) { 
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        child: Text('CB'),
      ),
      label: Text(chat),
    );
  }
} // ChatScreen class