import 'package:axiocash/controller/AxioController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../component/AxioTile.dart';

class ReminderPage extends StatelessWidget {
  ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Reminder',
      )),
      body: Consumer<AxioController>(builder: (context, pro, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: ListView.builder(
              itemCount: pro.axiolist.length,
              itemBuilder: (context, index) {
                DateTime dateTime = DateTime.now();
                String currentDateTimeFormatted =
                    DateFormat("MMM d, yyyy").format(dateTime);
                Logger().t(
                    '${pro.axiolist[index].date} ${currentDateTimeFormatted}');

                return currentDateTimeFormatted == pro.axiolist[index].date &&
                        pro.axiolist[index].type == 'DEBIT'
                    ? GestureDetector(
                        onTap: () {},
                        child: AxioTile(
                          name: pro.axiolist[index].name ?? '',
                          item: pro.axiolist[index].item ?? '',
                          amount: '${pro.axiolist[index].amount}',
                          type: pro.axiolist[index].type ?? '',
                          date: pro.axiolist[index].pdate,
                          phoneno: pro.axiolist[index].phno,
                          id: pro.axiolist[index].id,
                        ),
                      )
                    : Container();
              }),
        );
      }),
    );
  }
}
