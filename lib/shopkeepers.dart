import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AllShopKeeper extends StatefulWidget {
  @override
  _AllShopKeeperState createState() => _AllShopKeeperState();
}

class _AllShopKeeperState extends State<AllShopKeeper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All Shopkeeper"),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('shopkeeper').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(document.data['profile']),
                          backgroundColor: Colors.white,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.call),
                          color: Colors.deepPurple,
                          onPressed: () =>
                              launch("tel: +91${document.data['mobile']}"),
                        ),
                        title: Text(document.data['name']),
                        subtitle: Text("Shop : ${document.data['shopName']}"));
                  }).toList(),
                );
            }
          },
        ));
  }
}
