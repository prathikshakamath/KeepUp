import 'package:keep_up/pages/AddTodo.dart';

import '../Service/Auth_Service.dart';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'TodoCard.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Today's Schedule",
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
              child: Text(
                "Monday 21",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
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
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddToDoPage() ));
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
              ),
            ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 32,
              color: Colors.white,
            ),
            title: Container(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              TodoCard(
                title: "Wake up bro",
                check: true,
                iconBgColor: Colors.white,
                iconColor: Colors.red,
                iconData: Icons.alarm,
                time: "10AM",
              ),
              SizedBox(
                height: 10,
              ),
              TodoCard(
                title: "Let's do Gym",
                check: false,
                iconBgColor: Color(0xff2cc8d9),
                iconColor: Colors.white,
                iconData: Icons.run_circle,
                time: "11 AM",
              ),
              SizedBox(
                height: 10,
              ),
              TodoCard(
                title: "Buy some food",
                check: false,
                iconBgColor: Color(0xff19733),
                iconColor: Colors.white,
                iconData: Icons.local_grocery_store,
                time: "12 AM",
              ),
              SizedBox(
                height: 10,
              ),
              TodoCard(
                title: "Testing something",
                check: false,
                iconBgColor: Color(0xffd3c2b9),
                iconColor: Colors.white,
                iconData: Icons.audiotrack,

                time: "13 AM",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
