import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    // print(pickedDate);
    if (pickedDate == null) {
      return;
    }
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                },
                child: Text("Save Expense"),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
