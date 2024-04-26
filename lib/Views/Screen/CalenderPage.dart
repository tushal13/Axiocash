import 'package:axiocash/controller/AxioController.dart';
import 'package:axiocash/controller/CalenderControlle.dart';
import 'package:axiocash/views/component/AxioTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Model/AxModel.dart';

class CalenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AxioController axio = Provider.of<AxioController>(context, listen: false);

    DateTime earliestDate = axio.axiolist.isNotEmpty
        ? DateFormat("MMM d, yyyy").parse(
            Provider.of<AxioController>(context, listen: false)
                .axiolist
                .first
                .date!)
        : DateTime.now().subtract(const Duration(days: 0));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Data'),
        actions: [
          DropdownButton<String>(
            icon: const Icon(
              Icons.more_vert,
            ),
            onChanged: (value) {
              Provider.of<CalenderController>(context, listen: false)
                  .setFilter(value ?? 'All');
            },
            items: const [
              DropdownMenuItem(
                value: 'All',
                child: Text('All'),
              ),
              DropdownMenuItem(
                value: 'Debit',
                child: Text('Debit'),
              ),
              DropdownMenuItem(
                value: 'Income',
                child: Text('Income'),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<CalenderController>(
        builder: (context, pro, child) {
          pro.updateDateColorMapWithoutContext(axio.axiolist);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: HeatMapCalendar(
                  initDate: earliestDate,
                  defaultColor: Colors.grey.withOpacity(0.2),
                  textColor: Colors.black,
                  colorMode: ColorMode.color,
                  showColorTip: false,
                  borderRadius: 8,
                  colorTipCount: 10,
                  fontSize: 12,
                  size: 25,
                  margin: const EdgeInsets.all(4),
                  datasets: pro.dateColorMap,
                  colorsets: pro.filter == 'Income' || pro.filter == 'All'
                      ? pro.colorsets
                      : pro.colorsets2,
                  onClick: (date) {
                    pro.dateColorMap.clear();
                    pro.setSelectedDate(date);
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              pro.selectedDate != null
                  ? Text(
                      'Transactions for ${DateFormat("MMM d, yyyy").format(pro.selectedDate!)}:',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Recent Transactions',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
              Expanded(
                child: Consumer2<AxioController, CalenderController>(
                    builder: (context, axio, pro, _) {
                  List<AxioModal> filteredlist = axio.axiolist.where((ax) {
                    if (pro.filter == 'All') {
                      return true;
                    } else if (pro.filter == 'Debit') {
                      return ax.type == 'DEBIT';
                    } else if (pro.filter == 'Income') {
                      return ax.type == 'INCOME';
                    }
                    return false;
                  }).toList();
                  return filteredlist.isEmpty
                      ? Center(
                          child: Text(
                          "No Transactions Yet",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ))
                      : pro.selectedDate != null
                          ? ListView.builder(
                              itemCount: filteredlist.length,
                              itemBuilder: (context, index) {
                                AxioModal ax = filteredlist[index];

                                DateTime dateTime =
                                    DateFormat("MMM d, yyyy").parse(ax.date!);

                                return Provider.of<CalenderController>(context)
                                            .selectedDate ==
                                        dateTime
                                    ? AxioTile(
                                        name: ax.name,
                                        item: ax.item,
                                        amount: '${ax.amount}',
                                        type: ax.type,
                                        date: ax.pdate == ax.date
                                            ? ax.date
                                            : ax.pdate,
                                        phoneno: ax.phno,
                                        id: ax.id,
                                      )
                                    : Container();
                              },
                            )
                          : ListView.builder(
                              itemCount: filteredlist.length,
                              itemBuilder: (context, index) {
                                AxioModal ax = filteredlist[index];
                                return AxioTile(
                                  name: ax.name ?? '',
                                  item: ax.item ?? '',
                                  amount: '${ax.amount}',
                                  type: ax.type ?? '',
                                  date:
                                      ax.pdate == ax.date ? ax.date : ax.pdate,
                                  phoneno: ax.phno,
                                  id: ax.id,
                                );
                              });
                }),
              )
            ],
          );
        },
      ),
    );
  }
}
