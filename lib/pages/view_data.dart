import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key key,this.document,this.id}) : super(key: key);
  final Map<String, dynamic> document;
  final String id;

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  String type;
  String category;
  bool edit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title = widget.document["title"]==null
    ? "Hey there"
    : widget.document["title"];
     _titleController = TextEditingController(text: title);
     _descriptionController = 
         TextEditingController(text:widget.document ["description"]);
         type= widget.document["task"];
         category = widget.document["Category"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xff1d1e26),
        Color(0xff252041),
      ])),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: Colors.white,
              size: 28,
            ),
          ),
          Row(
            children:[
              IconButton(
            onPressed: () {
              FirebaseFirestore.instance
              .collection('Todo')
              .doc(widget.id)
              .delete()
              .then((value)  {
              Navigator.pop(context);
              });
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 28,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                edit = !edit;
              });
            },
            icon: Icon(
              Icons.edit,
              color: edit?Colors.green: Colors.white,
              size: 28,
            ),
          ),
            ],
          ),
          ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  edit?"Editing":"View",
                  style: TextStyle(
                    fontSize: 33,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Your Todo",
                  style: TextStyle(
                    fontSize: 33,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                label("Task Title"),
                SizedBox(
                  height: 12,
                ),
                title(),
                SizedBox(
                  height: 30,
                ),
                label("Task Type"),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    taskSelect("Important", 0xff2664fa),
                    SizedBox(
                      width: 20,
                    ),
                    taskSelect("Not Urgent", 0xff2bc8d9),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                label("Description"),
                SizedBox(
                  height: 12,
                ),
                description(),
                SizedBox(
                  height: 25,
                ),
                label("Category"),
                SizedBox(
                  height: 12,
                ),
                Wrap(
                  runSpacing: 10,
                  children: [
                    categorySelect("Food", 0xffff6d6e),
                    SizedBox(
                      width: 20,
                    ),
                    categorySelect("Exercise", 0xfff29732),
                    SizedBox(
                      width: 20,
                    ),
                    categorySelect("House", 0xff6557ff),
                    SizedBox(
                      width: 20,
                    ),
                    categorySelect("Work", 0xff234ebd),
                    SizedBox(
                      width: 20,
                    ),
                    categorySelect("Shop", 0xff2bc8d9),
                    SizedBox(
                      width: 20,
                    ),
                    categorySelect("Family", 0xff9bc359),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                edit?button() : Container(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      )),
    ));
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection('Todo').doc(widget.id).update({
          "title": _titleController.text,
          "task": type,
          "category": category,
          "description": _descriptionController.text
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xff8a32f1),
            Color(0xffad32f9),
          ]),
        ),
        child: Center(
          child: Text(
            "Update ToDo",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 125,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        enabled: edit,
        controller: _descriptionController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(
            right: 20,
            left: 20,
          ),
        ),
      ),
    );
  }

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: edit
      ?() {
        setState(() {
          type = label;
        });
      }
      :null,
      child: Chip(
        backgroundColor: type == label ? Colors.black : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(label),
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: edit
      ?() {
        setState(() {
          category = label;
        });
      }
      :null,
      child: Chip(
        backgroundColor: category == label ? Colors.black : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        label: Text(label),
        labelStyle: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        enabled: edit,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(
            right: 20,
            left: 20,
          ),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      "Task Title",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16.5,
        letterSpacing: 02,
      ),
    );
  }
}
