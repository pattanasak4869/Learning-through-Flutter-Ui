import 'package:apsfinancial/models/Transactions.dart';
import 'package:apsfinancial/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:apsfinancial/screens/form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'FINANCIAL APPLICATION'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FromScreen();
                  }));
                })
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider,Widget? child){
            var count = provider.transactions.length;
            if (count <= 0) {
              return Center(
                child: Text("ไม่พบการบันทึกข้อมูล" , style: TextStyle(fontSize: 20),),
              );
            }else{
              return ListView.builder(
              itemCount: count,
              itemBuilder: (BuildContext context, int index) {
              Transactions data = provider.transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text(data.amount.toString()),
                      )),
                  title: Text(data.title),
                  subtitle: Text(DateFormat("dd/MM/yyyy").format(data.date)),
                ),
              );
            });
            }
          },
          )
         // This trailing comma makes auto-formatting nicer for build methods.
      );
  }
}
