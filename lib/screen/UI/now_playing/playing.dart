

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:fireball/models/songs.dart';
import 'package:fireball/models/user.dart';
import 'package:fireball/screen/UI/now_playing/audio_player_manager.dart';
import 'package:fireball/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({
    super.key,
    required this.playingSong,
    required this.songs,
  });
  final Song playingSong;
  final List<Song> songs;
  @override
  Widget build(BuildContext context) {
    return NowPlayingPage(songs: songs, playingSong: playingSong);
  }
}

class NowPlayingPage extends StatefulWidget {
  final List<Song> songs;
  final Song playingSong;

  const NowPlayingPage({
    super.key,
    required this.songs,
    required this.playingSong,
  });
  /* const NowPlayingPage(
      {super.key, required List<Song> songs, required Song playingSong});
      
        get playingSong => null;*/

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _imageAnimationController;
  late AudioPlayerManager _audioPlayerManager;
  late int _selectedItemIndex;
  late Song _song;
  late LoopMode _loopMode;

  bool _isShuffle = false;
  @override
  void initState() {
    super.initState();
    _song = widget.playingSong;

    _imageAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 12000),
    );
    _audioPlayerManager = AudioPlayerManager(songUrl: _song.source);
    _audioPlayerManager.init();
    _loopMode = LoopMode.off;
    _selectedItemIndex = widget.songs.indexOf(widget.playingSong);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    final screenwidth = MediaQuery.of(context).size.width;
    const delta = 64;
    final radius = (screenwidth - delta) / 2;
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text("Now Playing"),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ),
        child: Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_song.album),
              const SizedBox(height: 16),
              const Text("_ ___ _"),
              const SizedBox(height: 48),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0)
                    .animate(_imageAnimationController),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/pexels-martin-péchy-5335216.jpg',
                    image: _song.image,
                    width: screenwidth - delta,
                    height: screenwidth - delta,
                    imageErrorBuilder: (context, error, StackTrace) {
                      return Image.asset(
                        'assets/pexels-martin-péchy-5335216.jpg',
                        width: screenwidth - delta,
                        height: screenwidth - delta,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 64, bottom: 16),
                child: SizedBox(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Column(
                      children: [
                        Text(
                          _song.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _song.artist,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () async {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _song.id ,
                            _song.title,
                            _song.album,
                            _song.artist,
                            _song.source,
                            _song.image,
                            _song.duration
                           );
                          await DatabaseService(uid: user.uid)
                              .getAllDocumentsFromIdCollection();
                        },
                        icon: const Icon(Icons.favorite_outline))
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 32, left: 24, right: 24, bottom: 16),
                child: _progressBar(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 32, left: 24, right: 24, bottom: 16),
                child: _MediaButton(),
              )
            ],
          )),
        ));
    // ignore: dead_code
  }

  @override
  void dispose() {
    _audioPlayerManager.player.dispose();
    super.dispose();
  }

  Widget _MediaButton() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MediaButtonControl(
              function: setShuffle,
              icon: Icons.shuffle,
              color: getShuffleColor(),
              size: 24),
          MediaButtonControl(
              function: setPrevSong,
              icon: Icons.skip_previous,
              color: Colors.deepPurple,
              size: 36),
          _playbutton(),
          // MediaButtonControl(
          //     function: null,
          //     icon: Icons.play_arrow_sharp,
          //     color: Colors.deepPurple,
          //     size: 48),
          MediaButtonControl(
              function: setNextSong,
              icon: Icons.skip_next,
              color: Colors.deepPurple,
              size: 36),
          MediaButtonControl(
              function: repeatOption,
              icon: _repeatingIcon(),
              color: getRepeatColor(),
              size: 24),
        ],
      ),
    );
  }

  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder<DurationState>(
        stream: _audioPlayerManager.durationState,
        builder: (context, snapshot) {
          final DurationState = snapshot.data;
          final progress = DurationState?.progress ?? Duration.zero;
          final buffered = DurationState?.buffered ?? Duration.zero;
          final total = DurationState?.total ?? Duration.zero;
          return ProgressBar(
            progress: progress,
            total: total,
            buffered: buffered,
            onSeek: _audioPlayerManager.player.seek,
            barHeight: 5,
            barCapShape: BarCapShape.round,
            baseBarColor: Colors.indigo,
            progressBarColor: Colors.green,
            bufferedBarColor: Colors.grey.withOpacity(0.3),
            thumbColor: Colors.deepPurple,
            thumbGlowColor: Colors.black,
            thumbRadius: 10.0,
          );
        });
  }

  StreamBuilder<PlayerState> _playbutton() {
    return StreamBuilder(
        stream: _audioPlayerManager.player.playerStateStream,
        builder: (context, snapshot) {
          final playState = snapshot.data;
          final processingState = playState?.processingState;
          final playing = playState?.playing;
          // if (_isRepeat == true &&
          //     playing == true &&
          //     processingState == ProcessingState.completed) {

          //   return MediaButtonControl(
          //       function: () {
          //         _audioPlayerManager.player.seek(Duration.zero);
          //       },
          //       icon: Icons.pause,
          //       color: null,
          //       size: 48);
          // } else
          if (processingState == ProcessingState.completed) {
            return MediaButtonControl(
                function: () {
                  _audioPlayerManager.player.seek(Duration.zero);
                },
                icon: Icons.replay,
                color: null,
                size: 48);
          } else if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return Container(
              margin: const EdgeInsets.all(8),
              width: 48,
              height: 48,
              child: const CircularProgressIndicator(),
            );
          } else if (playing != true) {
            return MediaButtonControl(
                function: () {
                  _audioPlayerManager.player.play();
                },
                icon: Icons.play_arrow,
                color: null,
                size: 48);
          } else if (playing == true) {
            return MediaButtonControl(
                function: () {
                  _audioPlayerManager.player.pause();
                },
                icon: Icons.pause,
                color: null,
                size: 48);
          } else {
            return MediaButtonControl(
              function: () {
                _audioPlayerManager.player.seek(Duration.zero);
              },
              icon: Icons.replay,
              color: null,
              size: 48,
            );
          }
        });
  }

  IconData _repeatingIcon() {
    return switch (_loopMode) {
      LoopMode.one => Icons.repeat_one,
      LoopMode.all => Icons.repeat_on,
      _ => Icons.repeat,
    };
  }

  void setShuffle() {
    setState(() {
      _isShuffle = !_isShuffle;
    });
  }

  void setNextSong() {
    if (_isShuffle) {
      var random = Random();
      _selectedItemIndex = random.nextInt(widget.songs.length);
    } else if (_selectedItemIndex < widget.songs.length - 1) {
      ++_selectedItemIndex;
    } else if (_loopMode == LoopMode.all &&
        _selectedItemIndex == widget.songs.length - 1) {
      _selectedItemIndex = 0;
    } else if (_loopMode == LoopMode.one) {
      _selectedItemIndex = _selectedItemIndex;
    }
    if (_selectedItemIndex > widget.songs.length) {
      _selectedItemIndex = _selectedItemIndex % widget.songs.length;
    }
    final nextsong = widget.songs[_selectedItemIndex];
    _audioPlayerManager.updateSongUrl(nextsong.source);
    setState(() {
      _song = nextsong;
    });
  }

  void setPrevSong() {
    if (_isShuffle) {
      var random = Random();
      _selectedItemIndex = random.nextInt(widget.songs.length);
    } else if (_selectedItemIndex > 0) {
      --_selectedItemIndex;
    }
    if (_selectedItemIndex < 0) {
      _selectedItemIndex = (_selectedItemIndex * -1) % widget.songs.length;
    }
    final nextsong = widget.songs[_selectedItemIndex];
    _audioPlayerManager.updateSongUrl(nextsong.source);
    setState(() {
      _song = nextsong;
    });
  }

  void repeatOption() {
    if (_loopMode == LoopMode.off) {
      _loopMode = LoopMode.one;
    } else if (_loopMode == LoopMode.one) {
      _loopMode = LoopMode.all;
    } else {
      _loopMode = LoopMode.off;
    }
    setState(() {
      _audioPlayerManager.player.setLoopMode(_loopMode);
    });
  }

  MaterialColor getShuffleColor() {
    return _isShuffle ? Colors.deepPurple : Colors.grey;
  }

  MaterialColor getRepeatColor() {
    return _loopMode != LoopMode.off ? Colors.deepPurple : Colors.grey;
  }
}

class MediaButtonControl extends StatefulWidget {
  const MediaButtonControl({
    super.key,
    required this.function,
    required this.icon,
    required this.color,
    required this.size,
  });
  final void Function()? function;
  final IconData icon;
  final double? size;
  final Color? color;
  @override
  State<StatefulWidget> createState() => _MediaButtonControlState();
}

class _MediaButtonControlState extends State<MediaButtonControl> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: widget.function,
      icon: Icon(widget.icon),
      iconSize: widget.size,
      color: widget.color ?? Theme.of(context).colorScheme.primary,
    );
  }
}
