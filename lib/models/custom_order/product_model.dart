class ProductModel {
  int? productCode;
  String? fruit;
  String? form;
  double? retailPrice;
  String? retailPriceUnit;
  double? productModelYield;
  double? cupEquivalentSize;
  String? cupEquivalentUnit;
  double? cupEquivalentPrice;
  String? productImage;

  ProductModel({
    this.productCode,
    this.fruit,
    this.form,
    this.retailPrice,
    this.retailPriceUnit,
    this.productModelYield,
    this.cupEquivalentSize,
    this.cupEquivalentUnit,
    this.cupEquivalentPrice,
    this.productImage,
  });

  ProductModel copyWith({
    int? productCode,
    String? fruit,
    String? form,
    double? retailPrice,
    String? retailPriceUnit,
    double? productModelYield,
    double? cupEquivalentSize,
    String? cupEquivalentUnit,
    double? cupEquivalentPrice,
    String? productImage,
  }) =>
      ProductModel(
        productCode: productCode ?? this.productCode,
        fruit: fruit ?? this.fruit,
        form: form ?? this.form,
        retailPrice: retailPrice ?? this.retailPrice,
        retailPriceUnit: retailPriceUnit ?? this.retailPriceUnit,
        productModelYield: productModelYield ?? this.productModelYield,
        cupEquivalentSize: cupEquivalentSize ?? this.cupEquivalentSize,
        cupEquivalentUnit: cupEquivalentUnit ?? this.cupEquivalentUnit,
        cupEquivalentPrice: cupEquivalentPrice ?? this.cupEquivalentPrice,
        productImage: productImage ?? this.productImage,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productCode: json["ProductCode"],
    fruit: json["Fruit"],
    form: json["Form"],
    retailPrice: json["RetailPrice"]?.toDouble(),
    retailPriceUnit: json["RetailPriceUnit"],
    productModelYield: json["Yield"]?.toDouble(),
    cupEquivalentSize: json["CupEquivalentSize"]?.toDouble(),
    cupEquivalentUnit: json["CupEquivalentUnit"],
    cupEquivalentPrice: json["CupEquivalentPrice"]?.toDouble(),
    productImage: json["ProductImage"],
  );

  Map<String, dynamic> toJson() => {
    "ProductCode": productCode,
    "Fruit": fruit,
    "Form": form,
    "RetailPrice": retailPrice,
    "RetailPriceUnit": retailPriceUnit,
    "Yield": productModelYield,
    "CupEquivalentSize": cupEquivalentSize,
    "CupEquivalentUnit": cupEquivalentUnit,
    "CupEquivalentPrice": cupEquivalentPrice,
    "ProductImage": productImage,
  };
}
