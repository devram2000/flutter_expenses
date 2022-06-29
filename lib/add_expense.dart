import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class AddExpense extends StatefulWidget {
  final Function addNewExpense;

  AddExpense(this.addNewExpense);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  // the variable to save the expense note input to
  final _noteController = TextEditingController();
  // the variable to save the cost note input to
  final _costController = TextEditingController();
  // the variable to save the expense date input to
  DateTime? _selectedDate;

  // function to add expense using _addNewExpense in main.dart file
  void _submitData() {
    // doesn't submit if no cost is entered 
    if (_costController.text.isEmpty) {
      return;
    }
    final enteredNote = _noteController.text;
    final enteredCost = double.parse(_costController.text);
    // doesn't submit if no note, cost is less than zero, or no date is inputteed
    if (enteredNote.isEmpty || enteredCost <= 0 || _selectedDate == null) {
      return;
    }
    // calling callback function to add expense
    widget.addNewExpense(
      enteredCost,
      enteredNote,
      _selectedDate,
    );
    // returning to main application
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    // shows calendar to pick dates
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    // pop up widget
    return AlertDialog(
      title: const Text('Add Expense'),
      content: Container(
        height: 300,
        child: Column(
            // centers popup widget vertically and horizontally
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Expense cost input field
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Expense Cost',
                ),
                controller: _costController,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))], 
                onSubmitted: (_) => _submitData(),
              ),
              // Expense note input field
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Expense Descriptive Note',
                ),
                controller: _noteController,
                onSubmitted: (_) => _submitData(),
              ),
              Row(
                children: [
                  // display date selected
                  Expanded(
                    child: Text(_selectedDate == null
                        ? ''
                        : DateFormat.yMd().format(_selectedDate as DateTime)),
                  ),
                  // button to show date selector
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text(
                      'Pick Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              // submit expense button
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Add Expense'),
              )
            ],
          ),
      ),
      actions: <Widget>[
        // close popup button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
    
  }
}
