class ProductData {
  String? productId;
  String? itemName;
  bool? isSelected;
  int qty = 0;

  ProductData({this.productId, this.itemName, this.qty = 0, this.isSelected});

  ProductData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    itemName = json['item_name'];
  }

  static List<ProductData> fromJsonList(List<Map<String, dynamic>> jsonList) {
    List<ProductData> _productData = [];
    for (var v in jsonList) {
      _productData.add(ProductData.fromJson(v));
    }
    return _productData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['item_name'] = this.itemName;
    return data;
  }
}