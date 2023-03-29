import 'package:equatable/equatable.dart';

class OrderStatus extends Equatable {
  final int id;
  final String uuid;
  final String status;
  final String created_at;

  const OrderStatus({
    required this.id,
    required this.uuid,
    required this.status,
    required this.created_at,
  });

  factory OrderStatus.fromJson(dynamic json) {
    return OrderStatus(
      id            : json['id'],
      uuid          : json['uuid'],
      status        : json['status'],
      created_at    : json['created_at'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    uuid,
    status,
    created_at,
  ];
}
