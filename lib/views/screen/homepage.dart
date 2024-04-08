import 'package:axiocash/controller/axiocontroller.dart';
import 'package:axiocash/views/component/axiotile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../controller/ThemeController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeController>(context).isDark;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Axiocash',
              style: GoogleFonts.poppins(
                  fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isDark ? Colors.white : Colors.black),
            ),
            child: IconButton(
              onPressed: () {
                Provider.of<ThemeController>(context, listen: false)
                    .changeTheme();
              },
              icon: isDark
                  ? Icon(
                      Icons.light_mode_outlined,
                      size: 20,
                    )
                  : Icon(
                      Icons.light_mode,
                      size: 20,
                    ),
            ),
          ),
        ],
      ),
      body: Consumer<AxioController>(builder: (context, pro, child) {
        double expanse = pro.axiolist
            .where((expense) => expense.type == "DEBIT")
            .fold(0.0, (sum, expense) => sum + (expense.amount ?? 0.0));

        double income = pro.axiolist
            .where((income) => income.type == "INCOME")
            .fold(0.0, (sum, income) => sum + (income.amount ?? 0.0));
        print(expanse);
        print(income);

        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isDark ? Color(0xff78FF3F) : Color(0xffE7FADF),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Income',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 1,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                        Text(
                          '\$ ${income.toStringAsFixed(2)}',
                          style: GoogleFonts.fahkwang(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isDark ? Color(0xffFF3838) : Color(0xffFFE3E3),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Debit',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 1,
                              color: isDark ? Colors.white : Colors.black),
                        ),
                        Text(
                          '\$ ${expanse.toStringAsFixed(2)}',
                          style: GoogleFonts.fahkwang(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recent Transaction',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 1,
                        )),
                    Text('view all',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          letterSpacing: 1,
                        )),
                  ],
                ),
              ),
              pro.axiolist.isEmpty
                  ? const Center(
                      child: Text(
                      'No Data',
                    ))
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ListView.builder(
                            itemCount: pro.axiolist.length,
                            itemBuilder: (context, index) {
                              DateTime dateTime = DateTime.now();
                              String currentDateTimeFormatted =
                                  DateFormat("MMM d, yyyy").format(dateTime);
                              Logger().t(
                                  '${pro.axiolist[index].date} ${currentDateTimeFormatted}');

                              return currentDateTimeFormatted ==
                                      pro.axiolist[index].date
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
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
