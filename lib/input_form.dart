import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: InputForm(),
    ),
  );
}

class InputForm extends StatefulWidget {
  // TODO コンストラクタの追加

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FormData _data = FormData();

  void _setLendOrRent(String value) {
    setState(() {
      _data.borrowOrLand = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('input'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              RadioListTile(
                value: "borrow",
                groupValue: _data.borrowOrLand,
                title: Text('借りた'),
                onChanged: (value) {
                  print('onchanged $value');
                  _setLendOrRent(value);
                },
              ),
              RadioListTile(
                value: "lend",
                groupValue: _data.borrowOrLand,
                title: Text('貸した'),
                onChanged: (value) {
                  print('onchanged $value');
                  _setLendOrRent(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: '貸し',
                  labelText: 'Name',
                ),
                onSaved: (value) {
                  _data.user = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormData {
  String borrowOrLand = "borrow";
  String user;
  String stuff;
  DateTime date = DateTime.now();
}
