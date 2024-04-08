import 'package:axiocash/helper/dbhelper.dart';
import 'package:axiocash/modal/axmodal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AxioController extends ChangeNotifier {
  List<AxioModal> axiolist = [];
  String date = '${DateFormat.yMMMd().format(DateTime.now())}';
  String pdate = '${DateFormat.yMMMd().format(DateTime.now())}';
  String time = '${TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}';
  String selecttype = 'INCOME';
  bool isDabit = false;
  String edittype = '';

  AxioController() {
    init();
  }

  init() async {
    axiolist = await DbHelper.dbHelper.getTransaction() ?? [];
    notifyListeners();
  }

  String selectType({required String type}) {
    selecttype = type;
    notifyListeners();
    return '';
  }

  String editType({required String type}) {
    selecttype = type;
    notifyListeners();
    return '';
  }

  showMyDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2999),
    );

    if (pickDate != null) {
      String formattedDate = DateFormat.yMMMd().format(pickDate);
      date = formattedDate;
    }
    notifyListeners();
  }

  showMypDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2999),
    );

    if (pickDate != null) {
      String formattedDate = DateFormat.yMMMd().format(pickDate);
      pdate = formattedDate;
    }
    notifyListeners();
  }

  showMyTime(BuildContext context) async {
    TimeOfDay? pickDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickDate != null) {
      time = pickDate.format(context);
    }

    notifyListeners();
  }
}
