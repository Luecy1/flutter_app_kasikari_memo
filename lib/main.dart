import 'package:flutter/material.dart';

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
      body: Center(
        child: Text(
          'hoge',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
