import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];
  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  title: Text(testList[index]),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: _add,
            child: Text('+'),
          ),
          RaisedButton(
            onPressed: _clear,
            child: Text('X'),
          ),
        ],
      ),
    );
  }

  void _add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = "卢洁辉 金丽丹";
    testList.add(temp);
    prefs.setStringList('testName', testList);
    _show();
  }

  _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('testName') != null) {
      setState(() {
        testList = prefs.getStringList('testName');
      });
    }
  }

  _clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear(); // 全部清除
    prefs.remove('testName');
    setState(() {
      testList = [];
    });
  }
}