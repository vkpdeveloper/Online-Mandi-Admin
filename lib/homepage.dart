import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onlinemandi_admin/methods.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseMethods _methods = FirebaseMethods();
  DocumentSnapshot allItems;
  List allData;
  TextEditingController _itemCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllItems();
  }

  getAllItems() async {
    allItems = await _methods.getItems();
    setState(() {
      allData = allItems.data['allItems'];
    });
  }

  addNewItem(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Close"),
                textColor: Colors.deepPurple,
              ),
              FlatButton(
                onPressed: () {
                  allData.add(_itemCont.text);
                  Firestore.instance
                      .collection('admin')
                      .document('items')
                      .setData({'allItems': allData}, merge: true);
                  Navigator.of(context).pop();
                  _itemCont.clear();
                  Fluttertoast.showToast(msg: "New Item Added");
                },
                child: Text("Add item"),
                textColor: Colors.deepPurple,
              )
            ],
            title: Text("Add New Item"),
            contentPadding: const EdgeInsets.all(15.0),
            content: TextField(
              controller: _itemCont,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  prefixIcon: Icon(Icons.check_box),
                  hintText: "Enter item name",
                  labelText: "Item name"),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => addNewItem(context),
            tooltip: "Add Item",
          )
        ],
        title: Text("Welcome, Admin"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                OptionContainer(
                  onPressed: () => Navigator.pushNamed(context, '/customers'),
                  parnetContext: context,
                  title: "All Customers",
                  subtitle: "See all of your customers details from here",
                  btnText: "See Customers",
                ),
                SizedBox(
                  height: 15.0,
                ),
                OptionContainer(
                  onPressed: () => Navigator.pushNamed(context, '/shopkeepers'),
                  parnetContext: context,
                  title: "All Shopkeepers",
                  subtitle: "See all of your shopkeepers details from here",
                  btnText: "See Shopkeepers",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onPressed;
  final BuildContext parnetContext;
  final String btnText;

  const OptionContainer(
      {Key key,
      this.title,
      this.subtitle,
      this.onPressed,
      this.parnetContext,
      this.btnText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 35,
      height: 160.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 25.0,
                color: Colors.black12.withOpacity(0.05),
                offset: Offset(10.0, 10.0)),
            BoxShadow(
                blurRadius: 25.0,
                color: Colors.black12.withOpacity(0.05),
                offset: Offset(-10.0, -10.0))
          ]),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                subtitle,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Align(
                alignment: Alignment.bottomRight,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0)),
                  color: Colors.deepPurple,
                  onPressed: onPressed,
                  child: Text(
                    btnText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
