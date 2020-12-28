import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:torch_compat/torch_compat.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool switchLight = false;
  Future<String> _dispatchNumber;
  String dispatchNum;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void callDispatch() async {
    futureConvert();
    String catNumber = "tel://" + dispatchNum;
    if (await canLaunch(catNumber)) {
      await launch(catNumber);
    }
  }

  void futureConvert() async {
    dispatchNum = await _dispatchNumber;
    print(dispatchNum);
  }

  void flashlight() {
    if (switchLight == false) {
      TorchCompat.turnOn();
      print("Light is on");
      switchLight = true;
      return;
    } else {
      switchLight = false;
      print("Light is off");
      TorchCompat.turnOff();
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _dispatchNumber = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('number'));
    });
    print(_dispatchNumber);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
            child: InkWell(
          onTap: () {
            flashlight();
          },
          child: ListTile(
            leading: Icon(Icons.flash_on),
            title: Text('Flashlight'),
          ),
        )),
        Card(
            child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Amazon Customer Service Phone Number'),
                            content: Text('1 (888) 280-4331'),
                          ));
                },
                child: ListTile(
                    leading: Icon(Icons.support_agent),
                    title: Text('Amazon Customer Service Phone Number')))),
        Card(
          child: InkWell(
            onTap: () {
              callDispatch();
            },
            child: ListTile(
              leading: Icon(Icons.phone),
              title: Text('Call Dispatch'),
            ),
          ),
        )
      ],
    );
  }
}
