import 'package:get/get.dart';
import 'package:localnotification_withsaqlite/database/sqlite_server.dart';
import 'package:localnotification_withsaqlite/model/model_timedate.dart';
class GetDataController extends GetxController{
  RxString selectedDate =''.obs;
  RxString selectedTime=''.obs;
  RxList<ModelTimedate> datalist=<ModelTimedate>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedDate.value='None';
    selectedTime.value='None';
    getDataFromDatabase();
  }
Future<void> getDataFromDatabase()async{
  final data=await SqliteServer.getData();
  datalist.clear();
  datalist.addAll(data);
  datalist.refresh();
}
}