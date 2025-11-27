class ProductAttributeModel {
  String? name;
  final List<String>? values;
  ProductAttributeModel({this.name, this.values});
  /// Json Format
  Map<String, dynamic> toJson() {
    return {'Name': name, 'Values': values};
  }

  /// from Firebase to Model
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    // Trả về một model rỗng nếu không có dữ liệu
    if (data.isEmpty) return ProductAttributeModel();

    // Tải dữ liệu
    return ProductAttributeModel(
      name: data['Name'] ?? '',
      // Kiểm tra 'Values' có null không trước khi chuyển đổi
      values: data['Values'] != null ? List<String>.from(data['Values']) : [],
    );
  }
}