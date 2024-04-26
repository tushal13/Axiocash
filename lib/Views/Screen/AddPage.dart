import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../Model/AxModel.dart';
import '../../controller/AxioController.dart';
import '../../controller/ThemeController.dart';
import '../../helper/DbHelper.dart';

class AddTransaction extends StatelessWidget {
  AddTransaction({super.key});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController customernameController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  AxioModal axio = AxioModal.init();

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeController>(context).isDark;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Transaction",
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Consumer<AxioController>(builder: (context, pro, child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Customer Name',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  TextFormField(
                    controller: customernameController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Customer Name";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Customer Name",
                      hintStyle: GoogleFonts.roboto(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Customer Phone Number',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  TextFormField(
                    controller: phoneController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Customer Phone Number";
                      }
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Customer Phone Number",
                      hintStyle: GoogleFonts.roboto(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.grey.withOpacity(0.2),
                    ),
                    maxLength: 10,
                  ),
                  Text(
                    'Item Name',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  TextFormField(
                    controller: itemController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Item Name";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Item Name",
                      hintStyle: GoogleFonts.roboto(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.grey.withOpacity(0.2),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Amount',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  TextFormField(
                    controller: amountController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter Amount of Items";
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter Amount",
                      prefixText: '₹',
                      hintStyle: GoogleFonts.roboto(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: isDark
                          ? Colors.white.withOpacity(0.05)
                          : Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Type',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 15, left: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (pro.selecttype == 'INCOME')
                                    ? Colors.blue
                                    : Colors.grey,
                                width: 1),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                activeColor: Colors.blue,
                                value: 'INCOME',
                                groupValue: pro.selecttype,
                                onChanged: (val) {
                                  pro.selectType(type: val ?? 'INCOME');
                                  axio.type = val ?? 'INCOME';
                                }),
                            const Text(
                              'INCOME',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 15, left: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: (pro.selecttype == 'DEBIT')
                                  ? Colors.blue
                                  : Colors.grey,
                              width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                                activeColor: Colors.blue,
                                value: 'DEBIT',
                                groupValue: pro.selecttype,
                                onChanged: (val) {
                                  pro.selectType(type: val ?? 'INCOME');
                                  axio.type = val ?? 'DEBIT';
                                }),
                            const Text(
                              'DEBIT',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Visibility(
                    visible: pro.selecttype == 'INCOME' ? true : false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date & Time',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: size.width * 0.32,
                              decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.05)
                                      : Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 5),
                                child: Consumer<AxioController>(
                                    builder: (context, pro, child) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("${pro.time}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500)),
                                      IconButton(
                                          onPressed: () async {
                                            pro.showMyTime(context);
                                            axio.time = pro.time ??
                                                '${TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}';
                                          },
                                          icon: const Icon(
                                            Icons.access_time_rounded,
                                            size: 20,
                                          )),
                                    ],
                                  );
                                }),
                              ),
                            ),
                            Container(
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.05)
                                      : Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 5),
                                child: Consumer<AxioController>(
                                    builder: (context, pro, child) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${pro.date}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            pro.showMyDate(context);
                                            axio.date = pro.date;
                                          },
                                          icon: const Icon(
                                            Icons.calendar_today_outlined,
                                            size: 16,
                                          )),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: pro.selecttype == 'DEBIT' ? true : false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pay later',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: size.width * 0.4,
                          decoration: BoxDecoration(
                              color: const Color(0xE7E0DFEC),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 5),
                            child: Consumer<AxioController>(
                                builder: (context, pro, child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "${pro.pdate}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        pro.showMypDate(context);

                                        axio.pdate = pro.pdate;
                                      },
                                      icon: const Icon(
                                        Icons.calendar_today_outlined,
                                        size: 16,
                                      )),
                                ],
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Consumer<AxioController>(builder: (context, pro, child) {
                    return GestureDetector(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          axio.id = 0;
                          axio.name = customernameController.text;
                          axio.phno = phoneController.text;
                          axio.date = pro.date;
                          axio.time = pro.time;
                          axio.type = pro.selecttype ?? 'EXPANSE';
                          axio.item = itemController.text ?? axio.name;
                          axio.pdate = pro.pdate;
                          axio.amount =
                              double.parse(amountController.text) ?? 0;

                          Logger().f(
                              "Amount: ${axio.amount} \n date: ${axio.date}\nname: ${axio.name}\nphno: ${axio.phno} \ntime: ${axio.time} \n description: ${axio.item} \ntype: ${axio.pdate}");

                          await DbHelper.dbHelper.insertTransaction(axio);
                          pro.init();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      ' Transaction added successfully.')));
                          Navigator.of(context).pop();
                          amountController.clear();
                          itemController.clear();
                          phoneController.clear();
                          pro.selecttype = 'INCOME';
                          pro.date = DateFormat.yMMMd().format(DateTime.now());
                          pro.time =
                              '${TimeOfDay.now().hour % 12}:${TimeOfDay.now().minute}';
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: const Color(0xFFD9626E),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'Add Transaction',
                          style: GoogleFonts.poppins(
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
