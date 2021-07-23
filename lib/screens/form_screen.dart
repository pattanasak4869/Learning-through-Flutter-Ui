import 'package:apsfinancial/models/Transactions.dart';
import 'package:apsfinancial/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FromScreen extends StatelessWidget {

  //controller
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("แบบฟอร์มบันทึกข้อมูล"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: new InputDecoration(labelText: "ชื่อรายการ"),
                  autofocus: true,
                  controller: titlecontroller,
                ),
                TextFormField(
                  decoration: new InputDecoration(labelText: "จำนวนเงิน"),
                  keyboardType:TextInputType.number,
                  controller: amountcontroller,
                ),
                FlatButton(
                  child: Text("เพิ่มข้อมูล"),
                  color: Colors.brown[700],
                  textColor: Colors.white,
                  onPressed: (){
                    var title = titlecontroller.text;
                    var amount = amountcontroller.text;

                    //เตรียมข้อมูล
                    Transactions statement = Transactions(
                      title: title,
                      amount: double.parse(amount),
                      date: DateTime.now()
                    ); //object

                    //เรียก provider
                    var provider = Provider.of<TransactionProvider>(context, listen:false);
                    provider.addTransaction(statement);
                    Navigator.pop(context);
                  },
                )
              ],
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
        ));
  }
}
