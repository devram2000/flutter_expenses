import 'package:flutter/material.dart';
import './expense.dart';
import 'add_expense.dart';
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
  final List<Expense> _addedExpenses = [];

  int _index = 0;

  // creation of list of example expenses to test scroll functionality
  List<Expense> get _exampleExpenses {
  
    List<Expense> expenseList = [];

    // ids start after _userExpenses ids
    int i = _addedExpenses.length + 1;
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
    return _addedExpenses + _exampleExpenses;
  }

  // function to add a new expense to the list
  void _addNewExpense(double cost, String note, DateTime date) {
    final addedExpense = Expense(
        id: _index,
        cost: cost,
        note: note,
        date: date);
    setState(() {
      _addedExpenses.insert(0, addedExpense);
      _index += 1;
    });
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
              // Heading for 'Your Expenses'
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
                    // aligns text to center
                    alignment: Alignment.center, 
                    // adds padding around expense text
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 5,
                    ),
                    // Text with expense information in the format of Expense Note: Cost, Date
                    child: Text(
                      '${_expenses[index].note.toString()}: \$${_expenses[index].cost.toString()}, ${  DateFormat.yMd().format(_expenses[index].date) }',
                      style: const TextStyle(
                            fontSize: 18
                      ),
                      textAlign: TextAlign.center,

                    ),
                  ));
                  
                },
                itemCount: _expenses.length,
              ),
            ),
          ],
        ),
      ),
      // button to open up new transaction popup
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            showDialog(
              context: context,
              // uses AddExpense pop up dialogue in the add_expense.dart file
              builder: (BuildContext context) => AddExpense(_addNewExpense),
            );
          },
        child: const Icon(Icons.add),
      ), 
    );
  }
}
