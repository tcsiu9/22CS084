import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String uuid;
  final String status;
  final String updated_at;

  const Task({
    required this.id,
    required this.uuid,
    required this.status,
    required this.updated_at,
  });

  factory Task.fromJson(dynamic json){
    return Task(
      id            : json['id'],
      uuid          : json['uuid'],
      status        : json['status'],
      updated_at    : json['updated_at'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, uuid, status, updated_at];

}