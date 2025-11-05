import 'dart:math';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localnotification_withsaqlite/controller/getdata_controller.dart';
import 'package:localnotification_withsaqlite/database/sqlite_server.dart';
import 'package:localnotification_withsaqlite/model/model_timedate.dart';
import 'package:localnotification_withsaqlite/screens/show_items.dart';

class MyHome extends StatefulWidget {
  static const routname = '/home';
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    void getTime() async {
      DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) {
          return Theme(data: ThemeData.dark(), child: child!);
        },
      );
      if (selectedDate != null) {
        final today = DateTime.now();
        final thedateonlytoday = DateTime(today.year, today.month, today.day);
        final pikeddaty = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
        );
        if (pikeddaty.isBefore(thedateonlytoday)) {
          Get.snackbar(
            'تنبيه ',
            'الرجاء اختيار تاريخ لاحق للتاريخ الحالي',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        final mydate = DateFormat('yyyy-MM-dd').format(selectedDate);
        Get.find<GetDataController>().selectedDate.value = mydate;
      }
    }

    getTheTime() async {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        final datenow = DateTime.now();
        final pikeddate = DateTime(
          datenow.year,
          datenow.month,
          datenow.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        if (pikeddate.isBefore(datenow)) {
          Get.snackbar(
            'تنبيه',
            'الرجاء اختيار وقت لاحق للوقت الحالي',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
        final mytime = DateFormat('hh:mm a').format(pikeddate);
        print('============Picked Time $mytime');
        Get.find<GetDataController>().selectedTime.value = mytime;
      }
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF0a0a0a)),
      backgroundColor: Color(0xFF0a0a0a),
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('images/planet.png')),
          Positioned(
            right: 0,
            top: 0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0a0a0a),
              ),
              onPressed: () {},
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Positioned(left: 0, top: 0,
            child: ElevatedButton(style:ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0a0a0a),
            ),onPressed: () {
              Get.toNamed(ShowItems.routname);
            }, child: Text('Show Items',
            style: TextStyle(color: Colors.white, fontSize: 20)
            )),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Obx(
                  () => Text(
                    Get.find<GetDataController>().selectedDate.value == ''
                        ? ''
                        : 'Selected Date: ${Get.find<GetDataController>().selectedDate.value}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
                Obx(
                  () => Text(
                    'Selected Time: ${Get.find<GetDataController>().selectedTime.value},',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0a0a0a),
                  ),
                  onPressed: () => getTime(),
                  child: Text(
                    'Get Date',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0a0a0a),
                  ),
                  onPressed: () => getTheTime(),
                  child: Text(
                    'Get Time',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0a0a0a),
                  ),
                  onPressed: () async {
                    String x = Get.find<GetDataController>().selectedDate.value;
                    String y = Get.find<GetDataController>().selectedTime.value;
                    ModelTimedate model = ModelTimedate(date: x, time: y);
                    await SqliteServer.insertData(model.toMap());
                    Get.find<GetDataController>().getDataFromDatabase();
                  },
                  child: Text(
                    'Save Data',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
