class Users {
  late final String uid;
  Users({required this.uid});
}

class UserData {
  late final String uid;
  late String id;
  late String title;
  late String album;
  late String artist;
  late String source;
  late String image;
  late int duration;

  UserData(
      {required this.uid,
      required this.id,
      required this.title,
      required this.album,
      required this.artist,
      required this.source,
      required this.image,
      required this.duration
      });
}
