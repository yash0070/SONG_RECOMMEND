import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'model_msg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  List<Message> messages = [
    // Message(
    //   text: 'Hii',
    //   date: DateTime.now().subtract(const Duration(minutes: 1)),
    //   isSentByMe: true,
    // ),
    // Message(
    //   text: 'Helloo!',
    //   date: DateTime.now().subtract(const Duration(minutes: 1)),
    //   isSentByMe: true,
    // ),
    // Message(
    //   text: 'How are you',
    //   date: DateTime.now().subtract(const Duration(minutes: 1)),
    //   isSentByMe: true,
    // ),
    // Message(
    //   text: 'Fine',
    //   date: DateTime.now().subtract(const Duration(minutes: 1)),
    //   isSentByMe: true,
    // ),
    // Message(
    //   text: 'Hii',
    //   date: DateTime.now().subtract(const Duration(minutes: 1)),
    //   isSentByMe: false,
    // ),
    // Message(
    //   text: 'Helloo!',
    //   date: DateTime.now().subtract(const Duration(minutes: 1)),
    //   isSentByMe: true,
    // ),
    // Message(
    //   text: 'How are you',
    //   date: DateTime.now().subtract(const Duration(minutes: 1)),
    //   isSentByMe: false,
    // ),
    // Message(
    //   text: 'Fine',
    //   date: DateTime.now().subtract(const Duration(minutes: 1)),
    //   isSentByMe: true,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: ,
      appBar: AppBar(
        title: Text("User"),
        backgroundColor: Color(0xff4169E1),
      ),
      body: Container(
        decoration: BoxDecoration(
            // gradient: const LinearGradient(
            //   colors: [
            //     // Color(0xffF778A1),
            //     Color.fromARGB(255, 108, 136, 223),
            //     Color.fromARGB(255, 212, 131, 156),
            //   ],
            //   begin: Alignment.bottomLeft,
            //   end: Alignment.topRight,
            //   stops: [0.4, 0.7],
            //   tileMode: TileMode.repeated,
            // ),
            ),
        child: Column(
          children: [
            Expanded(
              child: GroupedListView<Message, DateTime>(
                padding: const EdgeInsets.all(8),
                reverse: true,
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                floatingHeader: true,
                elements: messages,
                groupBy: (message) => DateTime(
                  message.date.year,
                  message.date.month,
                  message.date.day,
                ),
                groupHeaderBuilder: (Message message) => SizedBox(
                  height: 40,
                  child: Center(
                    child: Card(
                      color: Color(0xff4169E1),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          DateFormat.yMMMd().format(message.date),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                itemBuilder: (context, Message message) => Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: InkWell(
                    onLongPress: () {
                      if (!message.isSentByMe) {
                        showModalBottomSheet(
                            isDismissible: false,
                            enableDrag: false,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(28),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return const BottomSheetContainer();
                            });
                      }
                    },
                    child: Card(
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(message.text),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
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
                        // color: Colours.bgColor,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Row(
                        children: [
                          // SvgPicture.asset("images/icons/smile.svg"),
                          SizedBox(
                            width: size.width / 36,
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              controller: _textController,
                              cursorColor: Colors.deepPurple,
                              decoration: const InputDecoration(
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
                  Visibility(
                    visible: _textController.text
                        .isNotEmpty, // If message is not empty then send button will visible
                    child: GestureDetector(
                      onTap: () {
                        final message = Message(
                          text: _textController.text,
                          date: DateTime.now(),
                          isSentByMe: true,
                        );
                        setState(() {
                          messages.add(message);
                          _textController.clear();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                            color: Color(0xffF778A1),
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(0xffF778A1))),
                        child: Image.asset(
                          "assets/images/send.png",
                          height: 20,
                        ),
                        // child: SvgPicture.asset(
                        //   "images/icons/send.svg",
                        //   height: 17,
                        //   width: 11,
                        // ),
                      ),
                    ),
                    replacement: Container(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(12),
        topLeft: Radius.circular(12),
      )),
      padding: EdgeInsets.symmetric(
          horizontal: size.width / 36, vertical: size.height / 40),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.40),
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(5)),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                Text(
                  "Check Group Message",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              height: size.height * .05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Message Info",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name:",
                        style: TextStyle(fontSize: 16)
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        "John:",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Seat No:",
                        style: TextStyle(fontSize: 16)
                            .copyWith(color: Colors.black45),
                      ),
                      Text(
                        "32",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * .020,
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black45,
                  ),
                  SizedBox(
                    height: size.height * .020,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Delete Message",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.block,
                      size: 30,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Block User",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
