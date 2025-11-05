import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localnotification_withsaqlite/controller/getdata_controller.dart';
class ShowItems extends StatefulWidget {
  static const routname='/showitems';
  const ShowItems({super.key});

  @override
  State<ShowItems> createState() => _ShowItemsState();
}

class _ShowItemsState extends State<ShowItems> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Color(0xFF0a0a0a) ,
      appBar: AppBar(centerTitle: true,
        title: Text('Show Items'),
      ),
      body:Obx(
        ()=> ListView.builder(
          itemCount: Get.find<GetDataController>().datalist.length,
          itemBuilder:(context,index){
            final item = Get.find<GetDataController>().datalist[index];
            return ListTile(
              title: Text('Date: ${item.date}',style: TextStyle(color: Colors.white),),
              subtitle: Text('Time: ${item.time}',style: TextStyle(color: Colors.white),),
            );
        }),
      ),
    );
  }
}