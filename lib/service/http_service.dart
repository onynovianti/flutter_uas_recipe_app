import 'dart:convert';
import 'dart:io';
import 'package:flutter_api_praktikum/models/kategori.dart';
import 'package:http/http.dart' as http;
import '../models/masakan.dart';

class HttpService {
  final String baseUrl = 'https://masak-apa.tomorisakura.vercel.app/';

  // GET MASAKAN BARU
  Future<List?> getMasakanBaru() async {
    final String uri = baseUrl + 'api/recipes';

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      // print("sukses");
      final jsonResponse = json.decode(result.body);
      final masakanMap = jsonResponse['results'];
      // print(jsonResponse);
      List? masakan = (masakanMap?.map((i) => Masakan.fromJson(i)).toList());
      return masakan;
    } else {
      // ignore: avoid_print
      print("fail");
      return null;
    }
  }

  // GET DETAIL RESEP
  Future<Map<String, dynamic>?> getResep(key) async {
    final String uri = baseUrl + 'api/recipe/:' + key;
    // final String uri = baseUrl + 'api/recipes';

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      //   final map = response.body.jsonMap((e) => User.fromJson(e));
      // return map.values.toList();
      // print("sukses");
      final jsonResponse = json.decode(result.body);
      final masakanMap = jsonResponse['results'];
      Map<String, dynamic> masakan1 = Map.castFrom(masakanMap);
      // List? masakan = masakanMap.toList();
      // List? masakan =
      //     (masakanMap?.map((i) => Resep.fromJson(masakanMap)).toList());
      // print(masakan);
      // return masakan;
      return masakan1;
    } else {
      // ignore: avoid_print
      print("fail");
      return null;
    }
  }

  // SEARCH RESEP
  Future<List?> searchResep(key) async {
    final String uri = baseUrl + 'api/search/?q=' + key;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      // print("sukses");
      final jsonResponse = json.decode(result.body);
      final masakanMap = jsonResponse['results'];
      // print(jsonResponse);
      List? masakan = (masakanMap?.map((i) => Masakan.fromJson(i)).toList());
      return masakan;
    } else {
      // ignore: avoid_print
      print("fail");
      return null;
    }
  }

  // GET KATEGORI LIST
  Future<List?> getListKategori() async {
    final String uri = baseUrl + 'api/category/recipes';

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      // print("sukses");
      final jsonResponse = json.decode(result.body);
      final masakanMap = jsonResponse['results'];
      // print(jsonResponse);
      List? masakan = (masakanMap?.map((i) => Kategori.fromJson(i)).toList());
      return masakan;
    } else {
      // ignore: avoid_print
      print("fail");
      return null;
    }
  }

  // GET RESEP BY CATEGORY
  Future<List?> getResepCategory(key) async {
    final String uri = baseUrl + '/api/category/recipes/' + key;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      // print("sukses");
      final jsonResponse = json.decode(result.body);
      final masakanMap = jsonResponse['results'];
      // print(jsonResponse);
      List? masakan = (masakanMap?.map((i) => Masakan.fromJson(i)).toList());
      return masakan;
    } else {
      // ignore: avoid_print
      print("fail");
      return null;
    }
  }
}
