import 'package:apsfinancial/database/transaction_db.dart';
import 'package:apsfinancial/models/Transactions.dart';
import 'package:flutter/foundation.dart';

class TransactionProvider with ChangeNotifier{
    // ตัวอย่างข้อมูล
      List<Transactions> transactions = [];

      // ดึงข้อมูล
      List<Transactions> getTransaction(){
        return transactions;
      }

      void addTransaction(Transactions statement) async {
        var db = TransactionDB(dbName: "transactions.db");
        //บันทึกข้อมูล
        await db.InsertData(statement);

        await db.loadAllData();
        transactions.insert(0,statement);
        //แจ้งเตือน consumer
        notifyListeners();
      }
}