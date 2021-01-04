import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _userInputNumber = TextEditingController();

  void _setPhoneNumber(TextEditingController _phoneNumber) async {
    String _userInput = _phoneNumber.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('number', _userInput);
      print("It was added");
    });
  }

  @override
  void initState() {
    super.initState();
    _setPhoneNumber(_userInputNumber);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
            child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      content: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _userInputNumber,
                              keyboardType: TextInputType.numberWithOptions(
                                  signed: false, decimal: false),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Submit'),
                          onPressed: () {
                            _setPhoneNumber(_userInputNumber);
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ));
          },
          child: ListTile(
            leading: Icon(Icons.phone),
            title: Text('Change Dispatch Phone Number'),
          ),
        ))
      ],
    );
  }
}
