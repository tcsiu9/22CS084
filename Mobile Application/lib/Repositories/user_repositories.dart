import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fyp_app/Model/model_export.dart';
import 'package:fyp_app/Model/order_status.dart';

class UserRepositories {
  // static String mainUrl = 'http://10.0.2.2/api';
  static String mainUrl = 'https://amble-fyp.coding-free.com/api';
  String loginUrl = '$mainUrl/login';
  String taskUrl = '$mainUrl/index';
  String routeUrl = '$mainUrl/task/';
  String updateStatusUrl = '$mainUrl/order/update';
  String searchUrl = '$mainUrl/order/';
  String orderItemsUrl = '$mainUrl/order/view/';

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    return (value != null ? true : false);
  }

  Future<void> persistentToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<String> login(String username, String password) async {
    _dio.options.headers['User-Agent'] = 'FYP';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    print(loginUrl);
    Response response = await _dio.post(loginUrl, data: {
      'username': username,
      'password': password,
    });
    if (response.statusCode != 200) {
      throw Exception(response.data['message']);
    }
    return response.data['data']['token'];
  }

  Future<List<Task>> getAllTasks() async {
    var token = await storage.read(key: 'token');
    _dio.options.headers['User-Agent'] = 'FYP';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer $token';
    Response response = await _dio.get(taskUrl);
    if (response.statusCode != 200) {
      throw Exception(response.data);
    }
    // return responseData;
    final List json = response.data['data'];
    // return json;
    return json.map<Task>((e) => Task.fromJson(e)).toList();
  }

  Future<Task> getTask(String route_uuid) async {
    var token = await storage.read(key: 'token');
    _dio.options.headers['User-Agent'] = 'FYP';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer $token';
    Response response = await _dio.get('$routeUrl$route_uuid');
    if (response.statusCode != 200) {
      throw Exception(response.data);
    }
    final Map json = response.data['data'];
    return Task.fromJson(json);
  }

  Future<Map<String, OrderRoute>> getTaskDetails(String route_uuid) async {
    var token = await storage.read(key: 'token');
    _dio.options.headers['User-Agent'] = 'FYP';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer $token';
    Response response = await _dio.get('$routeUrl$route_uuid');
    if (response.statusCode != 200) {
      throw Exception(response.data);
    }
    final List json = response.data['data']['route_order'];
    return { for (var e in json) e['uuid'] : OrderRoute.fromJson(e) };
    // return json;
    // return json.map<String, OrderRoute>((v) => MapEntry(v[], OrderRoute.fromJson(v)));
  }

  Future<Map<String, Map<String, OrderStatus>>> getRouteStatus(String route_uuid) async {
    var token = await storage.read(key: 'token');
    _dio.options.headers['User-Agent'] = 'FYP';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer $token';
    Response response = await _dio.get('$routeUrl$route_uuid/status');
    if(response.statusCode != 200){
      throw Exception(response.data);
    }
    final Map<String, dynamic> json = response.data['data'];
    final Map<String, Map<String, OrderStatus>> status_list = {'preparing':{}, 'delivering':{}, 'finished':{}};

    var preparing = Map<String, dynamic>.fromEntries(json.entries.where((MapEntry e) => e.value['status'] == 'preparing'));
    var delivering = Map<String, dynamic>.fromEntries(json.entries.where((MapEntry e) => e.value['status'] == 'delivering'));
    var finished = Map<String, dynamic>.fromEntries(json.entries.where((MapEntry e) => e.value['status'] == 'finished'));

    // return preparing.map<String, OrderStatus>((k, v)=> MapEntry(k, OrderStatus.fromJson(v)));

    status_list['preparing']    = preparing.map<String, OrderStatus>((k, v)=> MapEntry(k, OrderStatus.fromJson(v)));
    status_list['delivering']   = delivering.map<String, OrderStatus>((k, v)=> MapEntry(k, OrderStatus.fromJson(v)));
    status_list['finished']     = finished.map<String, OrderStatus>((k, v)=> MapEntry(k, OrderStatus.fromJson(v)));

    return status_list;
    // return json.map<String, OrderStatus>((k, v) => MapEntry(k, OrderStatus.fromJson(v)));
  }

  Future<bool> updateOrderStatus(String scanData) async {
    var token = await storage.read(key: 'token');
    _dio.options.headers['User-Agent'] = 'FYP';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer $token';
    Response response = await _dio.post(updateStatusUrl, data: scanData);
    // return response;
    if(response.statusCode != 200){
      // throw Exception(response.data);
      return false;
    }
    return true;
  }

  Future<Map<String, dynamic>> searchOrder(String uuid) async {
    _dio.options.headers['User-Agent'] = 'FYP';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    Response response = await _dio.get('$searchUrl$uuid');
    if(response.statusCode != 200){
      throw Exception(response.data);
    }
    final Map<String, dynamic> json = response.data['data'];
    return json;
  }

  Future<List<OrderItems>> getOrderItems(String uuid) async {
    List<OrderItems> orderItemsList = [];
    var token = await storage.read(key: 'token');
    _dio.options.headers['User-Agent'] = 'FYP';
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Authorization'] = 'Bearer $token';
    Response response = await _dio.get('$orderItemsUrl$uuid');
    if(response.statusCode != 200){
      throw Exception(response.data);
    }
    final Map<String, dynamic> json = response.data['data'];
    json.forEach((key, value) => orderItemsList.add(OrderItems.fromJson(value)));
    return orderItemsList;
  }
}
