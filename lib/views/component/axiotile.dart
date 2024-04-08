import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:axiocash/helper/dbhelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/ThemeController.dart';
import '../../controller/axiocontroller.dart';

class AxioTile extends StatelessWidget {
  int? id;
  String? name;
  String? item;
  String? amount;
  String? type;
  String? date;
  String? phoneno;
  AxioTile(
      {super.key,
      required this.id,
      required this.name,
      required this.item,
      required this.amount,
      required this.type,
      required this.date,
      required this.phoneno});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeController>(context).isDark;
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          headerAnimationLoop: false,
          animType: AnimType.scale,
          title: 'Warning',
          desc: 'Are you sure you want to delete the item',
          btnCancelOnPress: () {
            Provider.of<AxioController>(context, listen: false).init();
          },
          btnOkOnPress: () async {
            await DbHelper.dbHelper.deleteTransaction(id ?? 0);
            Provider.of<AxioController>(context, listen: false).init();
          },
        ).show();
      },
      movementDuration: Duration(seconds: 1),
      onDismissed: (direction) async {
        print('Item dismissed');
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text('Delete',
                style: TextStyle(
                  color: Colors.white,
                )),
          ],
        ),
      ),
      child: GestureDetector(
        onLongPress: () {
          showAdaptiveDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    scrollable: true,
                    backgroundColor: isDark ? Colors.black : Colors.white,
                    title: Text(
                      'Edit Transaction',
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        TextFormField(
                            initialValue: name,
                            onChanged: (value) {
                              name = value;
                            },
                            onSaved: (value) {
                              name = value;
                              Logger().t(name);
                            },
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                fontSize: 18),
                            decoration: InputDecoration(
                              hintText: 'Name',
                              filled: true,
                              fillColor: isDark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.grey.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Item',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        TextFormField(
                          initialValue: item,
                          onChanged: (value) {
                            item = value;
                          },
                          onSaved: (value) {
                            item = value;
                            Logger().t(item);
                          },
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              fontSize: 18),
                          decoration: InputDecoration(
                            hintText: 'Item',
                            filled: true,
                            fillColor: isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.grey.withOpacity(0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Amount',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        TextFormField(
                            initialValue: amount,
                            onChanged: (value) {
                              amount = value;
                            },
                            onSaved: (value) {
                              amount = value;
                              Logger().t(amount);
                            },
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                fontSize: 18),
                            decoration: InputDecoration(
                              hintText: 'Amount',
                              filled: true,
                              fillColor: isDark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.grey.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Phone No',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        TextFormField(
                            initialValue: phoneno,
                            onChanged: (value) {
                              phoneno = value;
                            },
                            onSaved: (value) {
                              phoneno = value;
                              Logger().t(phoneno);
                            },
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                fontSize: 18),
                            maxLength: 10,
                            decoration: InputDecoration(
                              hintText: 'Phone No',
                              filled: true,
                              fillColor: isDark
                                  ? Colors.white.withOpacity(0.05)
                                  : Colors.grey.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  await DbHelper.dbHelper.updateTransaction(
                                      name ?? '',
                                      phoneno ?? '',
                                      item ?? '',
                                      amount ?? '',
                                      id ?? 0);
                                  Provider.of<AxioController>(context,
                                          listen: false)
                                      .init();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Update',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green.shade600,
                                )),
                          ],
                        ),
                      ],
                    ));
              });
        },
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 9, right: 20),
                    child: Container(
                      padding: EdgeInsets.all(08),
                      width: 50,
                      height: 55,
                      child: type == 'INCOME'
                          ? Icon(
                              CupertinoIcons.arrow_up_circle,
                              color: isDark
                                  ? Color(0xff78FF3F)
                                  : Colors.green.shade600,
                            )
                          : Icon(
                              CupertinoIcons.arrow_down_circle,
                              color: isDark
                                  ? Color(0xffFF3838)
                                  : Colors.red.shade600,
                            ),
                      decoration: BoxDecoration(
                        color: type == 'INCOME'
                            ? isDark
                                ? Colors.green.shade700
                                : Colors.green.shade300
                            : isDark
                                ? Colors.red.shade300
                                : Colors.red.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name ?? '',
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(
                            item ?? '',
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            type == 'INCOME' ? '+ $amount' : '- $amount',
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: type == 'INCOME'
                                    ? Colors.green
                                    : Colors.red),
                          ),
                          type == 'INCOME'
                              ? Container()
                              : Text(
                                  date ?? '',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: type == 'INCOME' ? false : true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        launchUrl(Uri.parse('tel://+91 $phoneno'));
                      },
                      label:
                          Text('Call', style: TextStyle(color: Colors.white)),
                      icon: Icon(Icons.call, color: Colors.white),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 2,
                      color: Colors.grey.shade500,
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        await DbHelper.dbHelper.getTransaction();
                        await DbHelper.dbHelper
                            .collectTransaction(id ?? 0)
                            .then(
                                (value) => Logger().w('Transaction Collected'));
                        Provider.of<AxioController>(context, listen: false)
                            .init();
                      },
                      label: Text('Collect',
                          style: TextStyle(color: Colors.white)),
                      icon: Icon(Icons.check, color: Colors.white),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 2,
                      color: Colors.grey.shade500,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Uri smsLaunchUri = Uri(
                          scheme: 'sms',
                          path: '+91 $phoneno',
                          queryParameters: <String, String>{
                            'body':
                                'Payment Not Received for $item on $date for $amount. Please Pay. it is friendly reminder for you. from axiocash.',
                          },
                        );
                        launchUrl(Uri.parse('$smsLaunchUri'));
                      },
                      label: Text('Message',
                          style: TextStyle(color: Colors.white)),
                      icon: Icon(CupertinoIcons.chat_bubble_2_fill,
                          color: Colors.white),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
