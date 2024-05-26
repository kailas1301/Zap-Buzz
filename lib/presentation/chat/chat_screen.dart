import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zapbuzz/presentation/utils/const/const.dart';
import 'package:zapbuzz/services/chat/chat_services.dart';
import 'package:zapbuzz/utils/widgets/textwidgets.dart';

class ChatScreen extends StatelessWidget {
  final String recieverUserEmail;
  final String recieverUserId;
  const ChatScreen(
      {super.key,
      required this.recieverUserEmail,
      required this.recieverUserId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController messagecontroller = TextEditingController();
    final ChatServices chatServices = ChatServices();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    void sendmessage() async {
      if (messagecontroller.text.isNotEmpty) {
        await chatServices.sendMessage(recieverUserId, messagecontroller.text);
        messagecontroller.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTextWidget(title: recieverUserEmail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            kSizedBoxH20,
            Expanded(
                child: StreamBuilder(
              stream: chatServices.getMessages(
                  recieverUserId, firebaseAuth.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("No message found"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    children: snapshot.data!.docs
                        .map((document) =>
                            buildMessageItem(document, firebaseAuth))
                        .toList(),
                  );
                }
              },
            )),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: messagecontroller,
                  decoration: const InputDecoration(hintText: "Enter message"),
                )),
                IconButton(
                    onPressed: () {
                      sendmessage();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: kAppPrimaryColor,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildMessageItem(DocumentSnapshot document, FirebaseAuth firebaseAuth) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  var alignment = (data["senderId"] == firebaseAuth.currentUser!.uid)
      ? Alignment.centerRight
      : Alignment.centerLeft;
  var color = (data["senderId"] == firebaseAuth.currentUser!.uid)
      ? kAppPrimaryColor
      : kDarkGreyColour;
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      alignment: alignment,
      child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SubHeadingTextWidget(
              title: data["message"],
              textColor: kwhiteColour,
            ),
          )),
    ),
  );
}
