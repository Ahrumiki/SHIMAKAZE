import 'dart:convert';

import 'package:fireball/models/songs.dart';
import 'package:http/http.dart' as http;

abstract interface class Datasource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements Datasource {
  @override
  Future<List<Song>?> loadData() async {
    const url = 'https://thantrieu.com/resources/braniumapis/songs.json';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodycontent = utf8.decode(response.bodyBytes);
      var songWrapper = jsonDecode(bodycontent) as Map;
      var songs = songWrapper['songs'] as List ; 
      return songs.map((song) => Song.fromJson(song)).toList();
    } else {
      return null;
    }
  }
}

class LocalDataSource implements Datasource {
  @override
  Future<List<Song>?> loadData() async {
    const url = 'https://thantrieu.com/resources/braniumapis/songs.json';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodycontent = utf8.decode(response.bodyBytes);
      var songWrapper = jsonDecode(bodycontent) as Map;
      var songs = songWrapper['songs']; 
      return songs.map((song) => Song.fromJson(song)).toList();
    } else {
      return null;
    }
  }
}
