import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zapbuzz/presentation/chat/chat_screen.dart';
import 'package:zapbuzz/presentation/utils/const/const.dart';
import 'package:zapbuzz/services/auth/auth_services.dart';
import 'package:zapbuzz/utils/widgets/elevatedbutton_widget.dart';
import 'package:zapbuzz/utils/widgets/textwidgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kwhiteColour,
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 90),
            child: AppBar(
              backgroundColor: kwhiteColour,
              elevation: 0,
              centerTitle: true,
              title: const AppBarTextWidget(title: "Zap Buzz"),
              actions: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: const Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 10),
                              child: SubHeadingTextWidget(
                                  textsize: 15,
                                  title: 'Are you sure you want to logout?'),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButtonWidget(
                                    buttonText: "Yes",
                                    width: 120,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      logOut(context);
                                    },
                                  ),
                                  ElevatedButtonWidget(
                                    width: 120,
                                    buttonText: "No",
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      );
                      // logOut(context);
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: kblackColour,
                    ))
              ],
            )),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("No user found");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data!.docs
                    .map<Widget>((doc) => buildUserTile(doc, auth, context))
                    .toList(),
              );
            }
          },
        ),
      ),
    );
  }
}

Future<void> logOut(BuildContext context) async {
  final authService = Provider.of<AuthServices>(context, listen: false);
  try {
    await authService.logOut();
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
  }
}

Widget buildUserTile(
    DocumentSnapshot document, FirebaseAuth auth, BuildContext context) {
  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  if (auth.currentUser!.email != data["email"]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: kwhiteColour,
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
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: const Icon(
              Icons.person,
              color: kAppPrimaryColor,
            ),
            trailing: const Icon(
              Icons.chat,
              color: kAppPrimaryColor,
            ),
            title: data["email"] != null
                ? SubHeadingTextWidget(
                    title: data["email"],
                    textColor: kAppPrimaryColor,
                  )
                : const Text("No Email"), // Handle missing data
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                        recieverUserEmail: data["email"],
                        recieverUserId: data["uid"]),
                  ));
            },
          ),
        ),
      ),
    );
  } else {
    return Container();
  }
}
