import 'package:customerservice/constants/custom_colors.dart';
import 'package:customerservice/localization/keys.dart';
import 'package:customerservice/models/order_model.dart';
import 'package:customerservice/screens/orders/orderDetail/detailController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:get/get.dart';

class OrderDetail extends StatelessWidget {
  final _controller = Get.put(DetailController());
  final OrderModel item;
  OrderDetail({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        title: Text(
          translate(Keys.orderDetail),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Card(
                elevation: 4,
                color: CustomColors.primaryLight,
                child: ListTile(
                  leading: Icon(
                    Icons.description_outlined,
                    color: CustomColors.primaryColor,
                    size: 50,
                  ),
                  title: Text(
                    "# ${item.orderId}",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: CustomColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Text(
                    item.orderStatus == 0
                        ? "Status : ACTIVE"
                        : item.orderStatus == 1
                            ? "Status : COMPLETED"
                            : "Status : CANCELLED",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color:
                              item.orderStatus == 2 ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Card(
                elevation: 4,
                color: CustomColors.primaryLight,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Service",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      trailing: Text(
                        item.service,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: CustomColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Created On",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      trailing: Text(
                        item.createdOn,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: CustomColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        height: 8,
                        thickness: 0.5,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your Details",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: CustomColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Name",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      trailing: Text(
                        item.name,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: CustomColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Contact",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      trailing: Text(
                        item.phone,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: CustomColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Email",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      trailing: Text(
                        item.email,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: CustomColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              item.orderStatus == 0
                  ? Row(
                      children: [
                        Expanded(
                          child: Obx(() => RaisedButton(
                                color: _controller.showLoader.value
                                    ? Colors.blueGrey
                                    : Colors.red,
                                onPressed: () {
                                  /// code to mark order as cancelled
                                  if (_controller.showLoader.value) {
                                    return;
                                  }
                                  _controller.updateOrderStatus(item, 2);
                                },
                                child: Text(
                                  "Mark as cancelled",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Obx(() => RaisedButton(
                                color: _controller.showLoader.value
                                    ? Colors.blueGrey
                                    : Colors.green,
                                onPressed: () {
                                  /// code to mark order as completed
                                  if (_controller.showLoader.value) {
                                    return;
                                  }
                                  _controller.updateOrderStatus(item, 1);
                                },
                                child: Text(
                                  "Mark as completed",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              )),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
