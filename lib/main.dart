import 'package:expense_planner/model/transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transactions.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  // options to set the device orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  //   ]
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primaryColor: Colors.purple,
        fontFamily: 'QuickSand',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'New shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 16.53,
        date: DateTime.now())
  ];

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  bool _showChart = false;

  void _addTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _onAddTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addTransaction),
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () {
              _onAddTransaction(context);
            },
            icon: const Icon(Icons.add))
      ],
    );
    final transactionListWidget = SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child:
                        TransactionList(_userTransactions, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Show Chart'),
                Switch(
                    activeColor: Theme.of(context).primaryColor,
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    }),
              ],
            ),
            if(!isLandscape) SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(_recentTransaction)),
            if(!isLandscape) transactionListWidget,
            if(isLandscape) _showChart
                ? SizedBox(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child: Chart(_recentTransaction))
                : transactionListWidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          _onAddTransaction(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
