class PaypalOrderModel {
  final String orderId;
  final String approveUrl;
  PaypalOrderModel({required this.orderId, required this.approveUrl});
  Map<String,dynamic> toJson(){
    return {
      "orderId":orderId,
      "approveUrl":approveUrl
    };
  }
  factory PaypalOrderModel.fromJson(Map<String,dynamic> json){
    return PaypalOrderModel(
      approveUrl: json['approveUrl'],
      orderId: json['orderId']
    );
  }
}