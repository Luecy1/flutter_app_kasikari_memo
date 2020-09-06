import 'package:flutter/material.dart';
import 'package:flutter_app_kasikari_memo/repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/list': (context) => MyListPage(),
      },
    );
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    load(context);

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: LinearProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> load(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacementNamed('/list');
  }
}

class MyListPage extends StatefulWidget {
  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kasikari'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              print('tap');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: Repository().memo(),
          builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot) {
            if (!snapshot.hasData) return const Text('Loading');
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => _buildList(context, snapshot.data[index]),
            );
          },
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            final snackBar = SnackBar(content: Text('Pressed!'));
            Scaffold.of(context).showSnackBar(snackBar);
          },
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, Memo data) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.android),
            title: Text('貸し出し中 ${data.stuff}'),
            subtitle: Text(data.date.toIso8601String() + '\n' + data.user),
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: [
                FlatButton(
                  child: Text('Edit'),
                  onPressed: () {
                    // TODO:編集画面へ遷移
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
