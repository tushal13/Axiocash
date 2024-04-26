import 'package:axiocash/controller/AxioController.dart';
import 'package:axiocash/views/component/AxioTile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Model/AxModel.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Consumer<AxioController>(builder: (context, pro, child) {
            {
              return ListView.builder(
                  itemCount: pro.axiolist.length,
                  itemBuilder: (context, index) {
                    pro.axiolist.sort((a, b) {
                      DateTime aDateTime =
                          DateFormat("MMM d, yyyy").parse(a.date!);
                      DateTime bDateTime =
                          DateFormat("MMM d, yyyy").parse(b.date!);
                      return bDateTime.compareTo(aDateTime);
                    });

                    AxioModal Axio = pro.axiolist[index];

                    bool isNewDate = index == 0 ||
                        (pro.axiolist[index].date ?? '') !=
                            (pro.axiolist[index - 1].date ?? '');
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isNewDate)
                          Text(
                            '${Axio.date}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        AxioTile(
                          name: Axio.name ?? '',
                          item: Axio.item ?? '',
                          amount: '${Axio.amount}',
                          type: Axio.type ?? '',
                          date:
                              Axio.pdate == Axio.date ? Axio.date : Axio.pdate,
                          phoneno: Axio.phno,
                          id: Axio.id,
                        ),
                      ],
                    );
                  });
            }
          }),
        ));
  }
}
