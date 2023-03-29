part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderError extends OrderState{
  final String error;

  const OrderError({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'OrderError {$error}';
}

class OrderLoaded extends OrderState {
  const OrderLoaded({
    this.orderItems = const <OrderItems>[],
  });

  final List<OrderItems> orderItems;

  OrderLoaded copyWith({List<OrderItems>? orderItems}) {
    return OrderLoaded(
      orderItems: orderItems ?? this.orderItems,
    );
  }

  @override
  List<Object> get props => [orderItems];
}
