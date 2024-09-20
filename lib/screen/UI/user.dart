import 'package:fireball/models/songs.dart';
import 'package:fireball/models/user.dart';
import 'package:fireball/screen/UI/now_playing/playing.dart';
import 'package:fireball/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const AccountTabPage();
  }
}

class AccountTabPage extends StatefulWidget {
  const AccountTabPage({super.key});

  @override
  State<AccountTabPage> createState() => _AccountTabPageState();
}

class _AccountTabPageState extends State<AccountTabPage> {
  List<Song> songs = [];

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final user = Provider.of<Users>(context);
  //   DatabaseService(uid: user.uid)
  //       .getAllDocumentsFromIdCollection()
  //       .then((value) {
  //     setState(() {
  //       songs = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    // return StreamProvider.value(
    //     value: DatabaseService(uid: user.uid)
    //     .getAllDocumentsFromIdCollection(),
    //     initialData: const <Song>[],
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Favourite'),
    //         centerTitle: true,
    //       ),
    //       body: getBody(),
    //     ));
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite'), centerTitle: true),
      body: StreamBuilder<List<Song>>(
          stream:
              DatabaseService(uid: user.uid).getAllDocumentsFromIdCollection(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              songs = snapshot.data!;
              return getBody();
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget getBody() {
    bool showLoading = songs.isEmpty;
    for (var song in songs) {
      print(song.album);
    }
    if (showLoading) {
      return getProgressBar();
    } else {
      return getListView();
    }
  }

  Widget getProgressBar() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  ListView getListView() {
    return ListView.separated(
      itemBuilder: (context, position) {
        return getRow(position);
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          thickness: 1,
          indent: 24,
          endIndent: 24,
        );
      },
      itemCount: songs.length,
      shrinkWrap: true,
    );
  }

  Widget getRow(int index) {
    return _SongItemSection(parent: this, song: songs[index]);
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
                height: 400,
                color: Colors.grey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal Bottom Sheet'),
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close Bottom Sheet'))
                    ],
                  ),
                )),
          );
        });
  }

  void navigate(Song song) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return NowPlaying(songs: songs, playingSong: song);
    }));
  }
}

class _SongItemSection extends StatelessWidget {
  const _SongItemSection({required this.parent, required this.song});

  final _AccountTabPageState parent;
  final Song song;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage.assetNetwork(
        placeholder: 'assets/pexels-martin-péchy-5335216.jpg',
        image: song.image,
        width: 48,
        height: 48,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/pexels-martin-péchy-5335216.jpg',
            width: 48,
            height: 48,
          );
        },
      ),
      title: Text(song.title),
      subtitle: Text(song.artist),
      trailing: IconButton(
        icon: const Icon(Icons.more_horiz),
        onPressed: () {
          parent.showBottomSheet();
        },
      ),
      onTap: () {
        parent.navigate(song);
      },
    );
  }
}
