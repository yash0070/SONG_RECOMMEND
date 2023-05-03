import 'package:flutter/material.dart';

class ChatMessagesField extends StatefulWidget {
  Function onTap;

  ChatMessagesField({required this.onTap});

  @override
  State<ChatMessagesField> createState() => _ChatMessagesFieldState();
}

class _ChatMessagesFieldState extends State<ChatMessagesField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: size.width / 18,
        right: size.width / 18,
        bottom: size.height / 40,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: size.width / 30),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.red,
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Row(
                children: [
                  // SvgPicture.asset("images/icons/smile.svg"),
                  SizedBox(
                    width: size.width / 36,
                  ),
                  const Expanded(
                    child: TextField(
                      cursorColor: Colors.deepPurple,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type Message..",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: size.width / 36,
          ),
          GestureDetector(
            onTap: () {
              widget.onTap();
            },
            child: Container(
                height: 42,
                width: 42,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
                child: Image.asset("assets/images/send.png")),
          )
        ],
      ),
    );
  }
}
