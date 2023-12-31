import 'package:expense_planner/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.mediaQuery,
    required this.deleteTransaction,
  });

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
                child: Text(
              '\$${transaction.amount}',
              style: const TextStyle(color: Colors.white),
            )),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle:
            Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: mediaQuery.size.width > 360 
        ? TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => deleteTransaction(transaction.id),
            icon: const Icon(Icons.delete),
            label: const Text('Delete')
          ) 
        : IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: () => deleteTransaction(transaction.id),
        ),
      ),
    );
  }
}