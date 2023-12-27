import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction(this.addTransaction, {super.key});

  final Function addTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  DateTime? _date;

  void _submitData() {
    final enteredTitle = _title.text;
    final enteredAmount = double.parse(_amount.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _date == null) {
      return;
    }
    widget.addTransaction(enteredTitle, enteredAmount, _date);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _date = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _title,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amount,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData,
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      child: Text(_date == null
                          ? 'No Date Chosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_date!)}')),
                  TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'Chose Date',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
