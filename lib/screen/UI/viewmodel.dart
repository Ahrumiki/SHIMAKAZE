import 'dart:async';
import 'package:fireball/models/songs.dart';
import 'package:fireball/repo/repositories.dart';

class MusicAppViewModel {
  StreamController<List<Song>> songStream = StreamController();

  void loadSongs() {
    final repository = DefaultRepository();
    repository.loadData().then((value) => songStream.add(value!));
  }
}
  