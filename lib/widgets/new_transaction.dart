import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class user {
  FirebaseAuth auth;
  user() {
    auth = FirebaseAuth.instance;
  }

  String inputData() {
    final User user = auth.currentUser;
    final uid = user.uid;
    return uid;
  }
}

class NewTransaction extends StatefulWidget {
  //const NewTrascation({ Key? key }) : super(key: key);

  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) return;
    widget.addTx(enteredTitle, enteredAmount); // way to use widget function
    final user u1 = new user();
    final String id = u1.inputData();

    FirebaseFirestore.instance.collection('expense').add({
      "item": enteredTitle,
      "cost": enteredAmount,
      "id": id,
      "time": DateTime.now()
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) => submitData(),
              /*onChanged: (value) {
                    //titleInput = value;
                     },*/
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
              //_ i get a argument i dont care about
              /*onChanged: (value) {
                    //amountInput = value;
                     },*/
            ),
            TextButton(
              onPressed: submitData,
              child: Text("Add New"),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
