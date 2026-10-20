import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/domain/model/accounting_ledger_model.dart';
import 'package:class_compass/feature/account_management/journal/domain/model/journal_body.dart';
import 'package:class_compass/feature/account_management/journal/domain/repository/journal_repository.dart';


class JournalController extends GetxController implements GetxService{
  final JournalRepository journalRepository;
  JournalController({required this.journalRepository});

  bool isLoading = false;
  Future<void> journalTransfer(JournalBody body) async {
    isLoading = true;
    update();
    Response? response = await journalRepository.journalTransfer(body);
    if(response != null && response.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("${response.body["message"]}", isError: false);
    }else{
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();
  }

  List<DebitCreditTransaction> debitCreditTransactionList = [];
  void addDebitCreditTransaction({bool notify = true}){
    debitCreditTransactionList.add(DebitCreditTransaction(
        ledgerId: null,
        item: null,
        debitController: TextEditingController(),
        creditController: TextEditingController()));
    if(notify){
      update();
    }
  }



  void updateSelectedLedgerItem(int index, AccountingLedgerItem item){
    debitCreditTransactionList[index].ledgerId = item.id;
    debitCreditTransactionList[index].item = item;
    update();
  }



  void removeDebitCreditTransaction(int index){
    debitCreditTransactionList.removeAt(index);
    update();
  }


  int debitEnabled = 0;
  void updateDebitCreditState(bool isDebit) {
   if(isDebit){
     debitEnabled = 1;
   }else{
     debitEnabled = 2;
   }
    update();
  }




}