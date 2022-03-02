import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Service/Auth_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/transaction.dart';

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

final user u1 = new user();
final String id = u1.inputData();

class TransactionList extends StatelessWidget {
  //const TransactionList({ Key? key }) : super(key: key);
  final List<Transactionx> userTransactions;

  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection("Todo")
      .where("id", isEqualTo: id)
      .snapshots();

  TransactionList(this.userTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      // child: ListView(
      //takes infinite height
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  '\$${userTransactions[index].amount.toStringAsFixed(2)}', // tx.amount.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.purple,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userTransactions[index].title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMMd().format(userTransactions[index]
                        .date), //DateFormat('yyyy-MM-dd').format(tx.date),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ));
        },
        itemCount: userTransactions.length,
        //children: userTransactions.map((tx) {}).toList(),
      ),
    );
  }
}
