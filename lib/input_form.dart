import 'package:flutter/material.dart';

import 'repository.dart';

void main() {
  runApp(
    MaterialApp(
      home: InputForm(),
    ),
  );
}

class InputForm extends StatefulWidget {
  final Memo memo;

  const InputForm({Key key, this.memo}) : super(key: key);

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

  Future<DateTime> _selectTime(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: _data.date,
        firstDate: DateTime(_data.date.year - 2),
        lastDate: DateTime(_data.date.year + 2));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.memo != null) {
      _data.borrowOrLand = widget.memo.borrowOrLend;
      _data.stuff = widget.memo.stuff;
      _data.date = widget.memo.date;
      _data.user = widget.memo.user;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('input'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              print('push save button');

              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                final memo = Memo(
                  borrowOrLend: this._data.borrowOrLand,
                  stuff: this._data.stuff,
                  date: DateTime.now(),
                  user: this._data.user,
                );
                Repository().saveMemo(memo);
                Navigator.pop(context);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Repository().fetchMemoList().then((value) {
                print(value);
              });
            },
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
