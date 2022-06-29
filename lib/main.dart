import 'package:flutter/material.dart';
import './expense.dart';
import 'dart:math';
import 'package:intl/intl.dart';


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

  // list of users expenses
  final List<Expense> _userExpenses = [];

  // creation of list of example expenses to test scroll functionality
  List<Expense> get _exampleExpenses {
  
    List<Expense> expenseList = [];

    // ids start after _userExpenses ids
    int i = _userExpenses.length + 1;
    Random rnd = Random();
    DateTime date = DateTime.now();
    
    // while loop to create X amount of transactions
    while (i < 1000) {
      // creation of example expenses with random costs less than $100
      expenseList.add(
        Expense(
          id: i,
          cost: (1 + rnd.nextInt(10000)).toDouble()/100,
          note: 'Expense ${i.toString()}',
          date: date,
        ),
      );
    i++;
    // subtracts date by one for next example expense
    date = date.subtract(const Duration(days: 1));
    }

    return expenseList;
  }

  // returns expenses list with _userExpenses and _exampleExpenses combined 
  // (remove _exampleExpenses from this statement if you don't want them)
  List<Expense> get _expenses {
    return _userExpenses + _exampleExpenses;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 5),
              // title of 'Your Expenses'
              child: const Text(
                'Your Expenses:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                  ),
              ),
            ),
            SizedBox(
              height: 500,
              // lazy load implementation to loop through all expenses
              child: ListView.builder(
                // builder for individual expense
                itemBuilder: (BuildContext context, int index) {
                  // card around expenses
                  return  Card(
                  // adds drop shadow
                  elevation: 5,
                  child: Container(
                    alignment: Alignment.center, 
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 5,
                    ),
                    child: Text(
                      '${_expenses[index].note.toString()}: \$${_expenses[index].cost.toString()}, ${  DateFormat.yMd().format(_expenses[index].date) }',
                      style: const TextStyle(
                            fontSize: 18
                            ),

                    ),
                  ));
                  
                },
                itemCount: _expenses.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
