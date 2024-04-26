import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Model/AxModel.dart';

class CalenderController with ChangeNotifier {
  String filter = 'All';
  Map<DateTime, int> dateColorMap = {
    DateTime(2022, 1, 1): 1,
  };
  Map<int, Color> colorsets = {
    1: Color.fromARGB(20, 2, 179, 8),
    2: Color.fromARGB(40, 2, 179, 8),
    3: Color.fromARGB(60, 2, 179, 8),
    4: Color.fromARGB(80, 2, 179, 8),
    5: Color.fromARGB(100, 2, 179, 8),
    6: Color.fromARGB(120, 2, 179, 8),
    7: Color.fromARGB(150, 2, 179, 8),
    8: Color.fromARGB(180, 2, 179, 8),
    9: Color.fromARGB(220, 2, 179, 8),
    10: Color.fromARGB(255, 2, 179, 8),
  };

  Map<int, Color> colorsets2 = {
    1: Color.fromARGB(20, 255, 0, 0),
    2: Color.fromARGB(40, 255, 0, 0),
    3: Color.fromARGB(60, 255, 0, 0),
    4: Color.fromARGB(80, 255, 0, 0),
    5: Color.fromARGB(100, 255, 0, 0),
    6: Color.fromARGB(120, 255, 0, 0),
    7: Color.fromARGB(150, 255, 0, 0),
    8: Color.fromARGB(180, 255, 0, 0),
    9: Color.fromARGB(220, 255, 0, 0),
    10: Color.fromARGB(255, 255, 0, 0),
  };

  DateTime? selectedDate;

  void setSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setFilter(String val) {
    filter = val;
    notifyListeners();
  }

  void updateDateColorMapWithoutContext(List<AxioModal> axions) {
    for (AxioModal axio in axions) {
      DateTime date = DateFormat("MMM d, yyyy").parse(axio.date ?? '');

      dateColorMap[date] = (dateColorMap[date] ?? 0) + 1;
      log('${dateColorMap}');
    }
  }
}
