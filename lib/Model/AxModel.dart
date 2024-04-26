import 'package:logger/logger.dart';

class AxioModal {
  int? id;
  String? name;
  String? phno;
  String? item;
  double? amount;
  String? date;
  String? time;
  String? type;
  String? pdate;

  AxioModal(
      {this.id,
      this.name,
      this.phno,
      this.item,
      this.amount,
      this.date,
      this.time,
      this.type,
      this.pdate});

  AxioModal.init() {
    Logger().d('AxioModal initialized...');
  }

  factory AxioModal.fromMap(Map Axio) {
    return AxioModal(
      id: Axio['id'],
      name: Axio['name'],
      phno: Axio['phno'],
      item: Axio['item'],
      amount: double.parse(Axio['amount']),
      date: Axio['date'],
      time: Axio['time'],
      type: Axio['type'],
      pdate: Axio['pdate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phno': phno,
      'item': item,
      'amount': amount,
      'date': date,
      'time': time,
      'type': type,
      'pdate': pdate,
    };
  }
}
