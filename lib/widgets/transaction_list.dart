import 'package:expense_planner/model/transaction.dart';
import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.deleteTransaction, {super.key});
  final Function deleteTransaction;
  final List<Transaction> transactions;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                    height: constraints.maxHeight * 0.60, 
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(transaction: transactions[index], mediaQuery: mediaQuery, deleteTransaction: deleteTransaction, key: ValueKey(transactions[index].id),);
            },
            itemCount: transactions.length,
          );
  }
}


