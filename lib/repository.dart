class Repository {
  Repository._internal();

  static Repository _instance;

  factory Repository() {
    if (_instance == null) _instance = Repository();
    return _instance;
  }

  Stream<Memo> memoStream() async* {
    await Future.delayed(Duration(seconds: 3));

    yield Memo(
      borrowOrLend: 'borrow',
      stuff: 'stuff',
      date: DateTime.now(),
      user: 'admin',
    );
  }
}

class Memo {
  final String borrowOrLend;
  final String stuff;
  final DateTime date;
  final String user;

  const Memo({this.borrowOrLend, this.stuff, this.date, this.user});
}
