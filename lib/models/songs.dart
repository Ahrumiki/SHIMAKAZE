

class Song {
  Song({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.source,
    required this.image,
    required this.duration,
  });

  factory Song.fromJson(Map<String, dynamic> map) {
    return Song(
      id: map['id'],
      title: map['title'],
      album: map['album'],
      artist: map['artist'],
      source: map['source'],
      image: map['image'],
      duration: map['duration'],
    );
  }

  late String id;
  late String title;
  late String album;
  late String artist;
  late String source;
  late String image;
  late int duration;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song && runtimeType == other.runtimeType && id == other.id;

  @override
  
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Song{id: $this.id, title: $title, album: $album, artist: $artist, source: $source, image: $image, duration: $duration}';
  }
}