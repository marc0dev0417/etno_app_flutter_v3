import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

import '../models/Event.dart';
import '../models/New.dart';
import '../models/Pharmacy.dart';

part 'section.g.dart';

class Section = SectionBase with _$Section;

abstract class SectionBase with Store {
  final String urlBase = 'http://192.168.137.1:8080/';

  @observable List<New> newList = [];
  @observable  New new_ = New.empty();
  @observable List<Event> eventList = [];
  @observable List<Pharmacy> pharmaciesList = [];

  @action
  Future<List<New>> getAllNewByLocality(String locality) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.137.1:8080/news?username=$locality'
        ),
      );
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List).map((e) => New.fromJson(e)).toList();
      newList = data;
      return data;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future<List<Event>> getAllEventsByLocality(String locality) async {
    try {
      final response = await http.get(Uri.parse('http://192.168.137.1:8080/events?username=$locality'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List).map((e) => Event.fromJson(e)).toList();
      eventList = data;
      return data;
    } catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  @action
  Future<List<Pharmacy>> getAllPharmaciesByLocality(String locality) async{
    try{
      final response = await http.get(Uri.parse('http://192.168.137.1:8080/pharmacies?username=$locality'));
      final decodeBody = utf8.decode(response.bodyBytes);
      final data = (jsonDecode(decodeBody) as List).map((e) => Pharmacy.fromJson(e)).toList();
      pharmaciesList = data;
      return data;
    }catch(e){
      debugPrint(e.toString());
      rethrow;
    }
  }

  @computed
  List<New> get getList => newList;
  @computed
  List<Event> get getListEvent => eventList;
  @computed
  New get getNew => new_;
  @computed
  List<Pharmacy> get getListPharmacy => pharmaciesList;

}