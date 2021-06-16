import 'package:customerservice/constants/custom_colors.dart';
import 'package:customerservice/localization/keys.dart';
import 'package:customerservice/models/order_model.dart';
import 'package:customerservice/screens/orders/orderDetail/orderDetail.dart';
import 'package:customerservice/screens/orders/orderHistory/controller/historyController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:get/get.dart';

class OrderHistory extends StatelessWidget {
  final _controller = Get.put(HistoryController());
  @override
  Widget build(BuildContext context) {
    _controller.getOrderHistory();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        title: Text(
          translate(Keys.history),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Obx(
            () => _controller.hasData.value
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      var model = _controller.data[index];
                      return orderItemView(context, model);
                    },
                    itemCount: _controller.data.length,
                  )
                : Center(
                    child: Text(_controller.message.value),
                  ),
          ),
        ),
      ),
    );
  }

  Widget orderItemView(context, OrderModel model) {
    return InkWell(
      onTap: () {
        Get.to(OrderDetail(
          item: model,
        ));
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: CustomColors.secondaryColor,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "# ${model.orderId}",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: CustomColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: model.orderStatus == 1 ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    model.orderStatus == 1 ? "COMPLETED" : "CANCELLED",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Service : ",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  model.service,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: CustomColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Ordered On : ",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  model.createdOn,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: CustomColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
