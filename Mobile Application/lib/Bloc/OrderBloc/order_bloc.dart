import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:equatable/equatable.dart';
import 'package:fyp_app/Bloc/bloc_export.dart';
import 'package:fyp_app/repositories/user_repositories.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final UserRepositories userRepositories;
  List<OrderItems> orderItems = [];

  OrderBloc({required this.userRepositories})
      : assert(userRepositories != null),
        super(OrderInitial()) {
    on<OrderFetched>((event, emit) async {
      try {
        orderItems = await userRepositories.getOrderItems(event.route_uuid);
        emit(OrderLoaded(orderItems: orderItems));
      } catch (error) {
        emit(OrderError(error: error.toString()));
      }
    });
  }
}
