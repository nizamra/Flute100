import 'dart:convert';

import 'package:flutter100/catCard.dart';
import 'package:http/http.dart' as http;

class Dattt {
  // void getCategories() async{
  static Future<List<Itemss>?> getCategories() async{
    //https://app.ecwid.com/api/v3/62626158/categories?token=public_riFWgdSARCbPzaBeRRAkbdBSmnBBP1ye
    final tokenParameters={'token':'public_riFWgdSARCbPzaBeRRAkbdBSmnBBP1ye'};
    final uri = Uri.https('app.ecwid.com','/api/v3/62626158/categories',tokenParameters);

    final apiResponse = await http.get(uri);
    // print(apiResponse.body);
    // final jsonData = jsonDecode(apiResponse.body);
    // return ApiRes.fromJson(jsonData);

    Map data = jsonDecode(apiResponse.body);
    List _temp = [];

    for(var i in data['items']){
      _temp.add(i);
    }

    return Itemss.itemsFromSnapshot(_temp);
  }
}

class Itemss{
  final int id;
  final String name;
  final String thumbnailUrl;

  Itemss({required this.id, required this.name, required this.thumbnailUrl});

  factory Itemss.fromJson(dynamic json){
    return Itemss(
        id: json['id'],
        name: json['name'],
        thumbnailUrl: json['thumbnailUrl']
    );
  }

  static List<Itemss> itemsFromSnapshot(List snapshot){
    return snapshot.map((data){
      return Itemss.fromJson(data);
    }).toList();
  }

}

class ApiRes{
  final Itemss items;

  ApiRes({required this.items});

  factory ApiRes.fromJson(Map<String, dynamic> json){
    final itemsJson = json['items'][0];
    final items = Itemss.fromJson(itemsJson);
    return ApiRes(items: items);
  }
}