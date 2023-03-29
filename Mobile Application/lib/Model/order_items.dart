import 'package:equatable/equatable.dart';

class OrderItems extends Equatable {
  final String productName;
  final String productNumber;

  const OrderItems({
    required this.productName,
    required this.productNumber,
  });

  factory OrderItems.fromJson(dynamic json) {
    return OrderItems(
      productName   : json['product_name'],
      productNumber : json['product_number'],
    );
  }

  @override
  List<Object?> get props => [
    productName,
    productNumber,
  ];
}
