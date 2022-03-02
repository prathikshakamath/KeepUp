// ignore_for_file: prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keep_up/pages/AddTodo.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:keep_up/pages/fin_home.dart';

import '../Service/Auth_Service.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'TodoCard.dart';
import 'view_data.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime date = DateTime.now();

  String formattedDate =
      formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]).toString();
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
  List<Select> selected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "ToDo",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/profilephoto.jpg"),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 22,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(35),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => AddToDoPage()));
              },
              child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigoAccent,
                        Colors.purple,
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    size: 32,
                    color: Colors.white,
                  )),
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (builder) => MApp()));
              },
              child: Container(
                  height: 52,
                  width: 52,
                  // decoration: BoxDecoration(
                  //   shape: BoxShape.circle,
                  //   gradient: LinearGradient(
                  //     colors: [
                  //       Colors.indigoAccent,
                  //       Colors.purple,
                  //     ],
                  //   ),
                  // ),
                  child: Icon(
                    Icons.monetization_on_outlined,
                    size: 32,
                    color: Colors.white,
                  )),
            ),
            title: Container(),
            // icon: Icon(

            //   Icons.monetization_on_outlined,
            //   size: 32,
            //   color: Colors.white,

            // ),
            //   icon: InkWell(
            //     onTap: () {
            //       Navigator.push(context,
            //           MaterialPageRoute(builder: (builder) => MApp()));
            //     },
            //   child: Container(),
            // ),
            // )
          )
        ],
      ),
      body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                IconData iconData;
                Color iconColor;
                Map<String, dynamic> document =
                    snapshot.data.docs[index].data() as Map<String, dynamic>;
                switch (document["category"]) {
                  case "Work":
                    iconData = Icons.bookmark;
                    iconColor = Colors.red;
                    break;

                  case "Food":
                    iconData = Icons.local_grocery_store_outlined;
                    iconColor = Colors.lightBlue;
                    break;

                  case "Exercise":
                    iconData = Icons.food_bank_rounded;
                    iconColor = Colors.blue;
                    break;

                  case "House":
                    iconData = Icons.house;
                    iconColor = Colors.blue;
                    break;

                  case "Family":
                    iconData = Icons.audiotrack;
                    iconColor = Colors.teal;
                    break;

                  case "Shop":
                    iconData = Icons.money;
                    iconColor = Colors.blue;
                    break;
                  default:
                    iconData = Icons.book_online;
                    iconColor = Colors.red;
                }
                selected.add(Select(
                    id: snapshot.data.docs[index].id, checkValue: false));
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => ViewData(
                          document: document,
                          id: snapshot.data.docs[index].id,
                        ),
                      ),
                    );
                  },
                  child: TodoCard(
                    title: document["title"] == null
                        ? "Hey There"
                        : document["title"],
                    check: document["done"],
                    iconBgColor: Colors.white,
                    iconColor: iconColor,
                    iconData: iconData,
                    time: "10AM",
                    index: index,
                    onChange: (int index) {
                      FirebaseFirestore.instance
                          .collection('Todo')
                          .doc(selected[index].id)
                          .update({"done": !document["done"]});
                      print(document["done"]);
                      setState(() {
                        selected[index].checkValue =
                            !selected[index].checkValue;
                      });
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}

class Select {
  String id;
  bool checkValue = false;
  Select({this.id, this.checkValue});
}
