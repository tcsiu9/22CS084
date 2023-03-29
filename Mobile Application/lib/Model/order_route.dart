import 'package:equatable/equatable.dart';

class OrderRoute extends Equatable {
  final int number;
  final String uuid;
  final String sex;
  final String first_name;
  final String last_name;
  final int phone_number;
  final String delivery1;
  final String? delivery2;
  final double lat;
  final double lng;
  final int demand;

  const OrderRoute({
    required this.number,
    required this.uuid,
    required this.sex,
    required this.first_name,
    required this.last_name,
    required this.phone_number,
    required this.delivery1,
    required this.delivery2,
    required this.lat,
    required this.lng,
    required this.demand,
  });

  factory OrderRoute.fromJson(dynamic json) {
    return OrderRoute(
      number        : json['number'],
      uuid          : json['uuid'],
      sex           : json['sex'],
      first_name    : json['first_name'],
      last_name     : json['last_name'],
      phone_number  : json['phone_number'],
      delivery1     : json['delivery1'],
      delivery2     : json['delivery2'] ?? '',
      lat           : json['lat'],
      lng           : json['lng'],
      demand        : json['demand'],
    );
  }

  @override
  List<Object?> get props => [
        number,
        uuid,
        sex,
        first_name,
        last_name,
        phone_number,
        delivery1,
        delivery2,
        lat,
        lng,
        demand,
      ];
}
