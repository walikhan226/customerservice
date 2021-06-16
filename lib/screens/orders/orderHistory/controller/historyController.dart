import 'package:customerservice/models/order_model.dart';
import 'package:customerservice/repositories/db_repository.dart';
import 'package:get/get.dart';

class HistoryController extends GetxController {
  final repo = DbRepository();
  var hasData = false.obs;
  var message = "".obs;
  var data = List<OrderModel>().obs;

  void getOrderHistory() {
    repo.getOrderHistory().then((snapshots) {
      hasData.value = true;
      var list = List<OrderModel>();
      data.clear();
      snapshots.forEach((element) {
        var model = OrderModel();
        model.name = element['name'];
        model.phone = element['phone'];
        model.email = element['email'];
        model.service = element['service'];
        model.location = element['location'];
        model.orderStatus = element['orderStatus'];
        model.orderId = element['orderId'];
        model.userId = element['userId'];
        model.createdOn = element['createdOn'];
        list.add(model);
      });

      data.addAll(list);
    }).catchError((error) {
      hasData.value = false;
      message.value = error.toString();
    });
  }
}
