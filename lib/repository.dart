class Repository {
  Future<List<Memo>> memo() async {
    await Future.delayed(Duration(seconds: 3));

    return [
      Memo(
        borrowOrLend: 'borrow',
        stuff: 'stuff',
        date: DateTime.now(),
        user: 'admin',
      ),
      Memo(
        borrowOrLend: 'borrow',
        stuff: '2',
        date: DateTime.now(),
        user: 'taro',
      ),
    ];
  }
}

class Memo {
  final String borrowOrLend;
  final String stuff;
  final DateTime date;
  final String user;

  const Memo({this.borrowOrLend, this.stuff, this.date, this.user});

  @override
  String toString() {
    return 'Memo{borrowOrLend: $borrowOrLend, stuff: $stuff, date: $date, user: $user}';
  }
}
