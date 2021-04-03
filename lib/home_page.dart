import 'package:chatapp/chat_message.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<AnimatedListState> _animListKey = GlobalKey<AnimatedListState>();
  TextEditingController _textEditingController = TextEditingController();

  List<String> _chats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
      ),
      body: Column(
        children: [
          Expanded(
              child: AnimatedList(
            key: _animListKey,
            reverse: true,
            itemBuilder: (context, index, animation) {
              return _buildItem(context, index, animation);
            },
          )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(hintText: "메세지 입력창"),
                    onSubmitted: _handleSubmitted,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                FlatButton(
                  onPressed: () {
                    _handleSubmitted(_textEditingController.text);
                  },
                  child: Text("Send"),
                  color: Colors.amberAccent,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(context, index, animation) {
    return ChatMessage(_chats[index], animation: animation);
  }

  void _handleSubmitted(String text) {
    print(text);

    _textEditingController.clear();
    _chats.insert(0, text);
    _animListKey.currentState.insertItem(0);
  }
}
