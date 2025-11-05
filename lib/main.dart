import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localnotification_withsaqlite/controller/getdata_controller.dart';
import 'package:localnotification_withsaqlite/screens/home_screen.dart';
import 'package:localnotification_withsaqlite/screens/show_items.dart';

void main() {
  runApp(const MyApp());
  Get.put(GetDataController(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: MyHome.routname,

      getPages: [
        GetPage(name:MyHome.routname, page:()=>MyHome()),
        GetPage(name:ShowItems.routname, page:()=>ShowItems())
      ],
    );
  }
}
