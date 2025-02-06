import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import './components/transactions_list.dart';
import '../models/transaction.dart';
import 'dart:math';


main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        fontFamily: 'Outfit',
        //useMaterial3: false,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          primary: Colors.deepPurple,
          secondary: Colors.indigo,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactions = <Transaction>[
    // Transaction(
    //   id: 't1',
    //   title: 'Novo Tenis',
    //   value: 310,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Conta de Luz',
    //   value: 211,
    //   date: DateTime.now(),
    // ) ,
  ];

  _addTransaction(String title, double value){
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now()
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _opentrasactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context, 
      builder: (_) {
        return TransactionForm(_addTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Despesas Pessoais',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () => _opentrasactionFormModal(context), 
              icon:Icon(Icons.add) 
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Card(
                  color: Colors.blue,
                  child: Text('Grafico'),
                ),
              ),
              TransactionsList(_transactions),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _opentrasactionFormModal(context)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}
