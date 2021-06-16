class OrderModel {
  String name = "";
  String phone = "";
  String email = "";
  String service = "";
  String location = "";
  int orderStatus = 0;
  String orderId = "";
  String userId = "";
  String createdOn = "";

  OrderModel();

  Map toMap(OrderModel model) {
    var data = Map<String, dynamic>();
    data['name'] = model.name;
    data['phone'] = model.phone;
    data['email'] = model.email;
    data['service'] = model.service;
    data['location'] = model.location;
    data['orderStatus'] = model.orderStatus;
    data['orderId'] = model.orderId;
    data['userId'] = model.userId;
    data['createdOn'] = model.createdOn;
    return data;
  }

  // Named constructor
  OrderModel.fromMap(Map<String, dynamic> mapData) {
    this.name = mapData['name'];
    this.phone = mapData['phone'];
    this.email = mapData['email'];
    this.service = mapData['service'];
    this.location = mapData['location'];
    this.orderStatus = mapData['orderStatus'];
    this.orderId = mapData['orderId'];
    this.userId = mapData['userId'];
    this.createdOn = mapData['createdOn'];
  }
}
