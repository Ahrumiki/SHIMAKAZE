import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireball/models/songs.dart';
import 'package:fireball/models/user.dart';
import 'package:google_api_availability/google_api_availability.dart';
class DatabaseService {
  late final String uid;
  DatabaseService({required this.uid});

  final CollectionReference ahrumikiCollection =
      FirebaseFirestore.instance.collection('Ahrumiki');

  // Future updateUserData(String id, String title, String album, String artist,
  //     String source, String image, int duration) async {
  //   return await ahrumikiCollection.doc(uid).collection('id').add({
  //     'id': id,
  //     'title': title,
  //     'album': album,
  //     'artist': artist,
  //     'source': source,
  //     'image': image,
  //     'duration': duration
  //   });
  // }
  Future<void> updateUserData(String id, String title, String album,
    String artist, String source, String image, int duration) async {
      QuerySnapshot query = await ahrumikiCollection
        .doc(uid)
        .collection('id')
        .where('id', isEqualTo: id)
        .get();
    if (query.docs.isNotEmpty) {
      for (QueryDocumentSnapshot doc in query.docs) {
        await doc.reference.delete();
      }
    } else {
      await ahrumikiCollection.doc(uid).collection('id').add({
        'id': id,
        'title': title,
        'album': album,
        'artist': artist,
        'source': source,
        'image': image,
        'duration': duration
      });
    }
  }

  Iterable<Song> _ahruListFromSnapShot(QuerySnapshot snapshots) {
    return snapshots.docs.map((doc) {
      return Song(
        id: (doc.data() as Map<String, dynamic>)['name'] ?? ' ',
        title: (doc.data() as Map<String, dynamic>)['sugars'] ?? ' ',
        album: (doc.data() as Map<String, dynamic>)['sugars'] ?? ' ',
        artist: (doc.data() as Map<String, dynamic>)['sugars'] ?? ' ',
        source: (doc.data() as Map<String, dynamic>)['sugars'] ?? ' ',
        image: (doc.data() as Map<String, dynamic>)['sugars'] ?? ' ',
        duration: (doc.data() as Map<String, dynamic>)['strength'] ?? 0,
      );
    }).toList();
  }

  // List<Ahru> _ahruListFromSnapShot(QuerySnapshot snapshots) {
  //   return snapshots.docs.map((doc) {
  //     return Ahru(name: name, sugars: sugars, strength: strength);
  //   });
  // }
  UserData _userDataFromSnapShot(DocumentSnapshot<Object?> snapshots) {
    // return UserData(
    //     uid: uid,
    //     name: snapshots.data()['name'],
    //     sugars: snapshots.data['sugars'],
    //     strength: snapshots.data['strength']);
    var data = snapshots.data() as Map<String, dynamic>?;
    return UserData(
      uid: uid,
      id: data!['id'],
      title: data['title'],
      album: data['album'],
      artist: data['artist'],
      source: data['source'],
      image: data['image'],
      duration: data['duration'],
    );
  }

  // Future<Either> addorRemoveFavouriteSong(String userid) {
  //   final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //   final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   firebaseFirestore.collection('Ahrumiki').doc(userid).collection('id').
  // }

  // Future<Iterable<Song>> getAllDocumentsFromIdCollection() async {
  //   final CollectionReference idCollection = FirebaseFirestore.instance
  //       .collection('Ahrumiki')
  //       .doc(uid)
  //       .collection('id');
  //   GooglePlayServicesAvailability availability = await GoogleApiAvailability
  //       .instance
  //       .checkGooglePlayServicesAvailability();

  //   switch (availability) {
  //     case GooglePlayServicesAvailability.success:
  //       print('Google Play Services are available.');
  //       break;
  //     case GooglePlayServicesAvailability.serviceMissing:
  //       print('Google Play Services are missing.');
  //       break;
  //     case GooglePlayServicesAvailability.serviceVersionUpdateRequired:
  //       print('Google Play Services require an update.');
  //       break;
  //     default:
  //       print('Google Play Services have an issue: $availability');
  //   }
  //   final QuerySnapshot querySnapshot = await idCollection.get();
  //   // QuerySnapshot querySnapshot =
  //   //     await ahrumikiCollection.doc(uid).collection(uid).get();
  //   // querySnapshot.docs.forEach((doc) {
  //   List<Song> listsong = [];

  //   //   print('Document ID: ${doc.id}');
  //   //   print('Data: ${doc.data()}');
  //   // });
  //   listsong = querySnapshot.docs.map((doc) {
  //     return Song(
  //       id: doc['id'],
  //       title: doc['title'],
  //       album: doc['album'],
  //       artist: doc['artist'],
  //       source: doc['source'],
  //       image: doc['image'],
  //       duration: doc['duration'],
  //     );
  //   }).toList();
  //   for (var song in listsong) {
  //     print(
  //         'Title: ${song.title}, Artist: ${song.artist}, Duration: ${song.duration} seconds');
  //   }
  //   return listsong;
  // }

  Stream<List<Song>> getAllDocumentsFromIdCollection() {
  final CollectionReference idCollection = FirebaseFirestore.instance
      .collection('Ahrumiki')
      .doc(uid)
      .collection('id');
  
  return idCollection.snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      return Song(
        id: doc['id'],
        title: doc['title'],
        album: doc['album'],
        artist: doc['artist'],
        source: doc['source'],
        image: doc['image'],
        duration: doc['duration'],
      );
    }).toList();
  });
  }

  Stream<Iterable<Song>> get ahru {
    return ahrumikiCollection.snapshots().map(_ahruListFromSnapShot);
  }

  Stream<UserData> get userData {
    return ahrumikiCollection.doc(uid).snapshots().map(
        _userDataFromSnapShot); //as DocumentSnapshot<Object?> Function(DocumentSnapshot<Object?> event));
  }
}
