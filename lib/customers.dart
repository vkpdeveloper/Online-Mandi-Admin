import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllCustomers extends StatefulWidget {
  @override
  _AllCustomersState createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Customers"),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('customer').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Some error occured !"),
            );
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(child: CircularProgressIndicator());
            default:
              return new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return new ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(document.data['profile']),backgroundColor: Colors.white,),
                    title: new Text(document.data['name']),
                    subtitle: new Text(document.data['email']),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
