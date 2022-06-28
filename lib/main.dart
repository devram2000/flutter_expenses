import 'package:flutter/material.dart';
import './expense.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Expenses Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Expense> _expenses = [];

List<Expense> get _allExpenses {
    List<Expense> expenseList = [];

    int i = 0;
    while (i < 1000) {
      expenseList.add(Expense(
      id: i,
      cost: 17.20,
      note: 'Expense ${i.toString()}',
      date: DateTime.now(),
    ),);
    i++;
    }

    return expenseList;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your Expenses:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
                ),
            ),
            Container(
              height: 500,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    '${_allExpenses[index].note.toString()}: ${_allExpenses[index].cost.toString()}, ${_allExpenses[index].date.toString()}\n',
                    style: TextStyle(
                          fontSize: 20
                          ),
                  );
                },
                itemCount: _allExpenses.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
