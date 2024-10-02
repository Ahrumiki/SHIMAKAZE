import 'package:fireball/models/ahru.dart';
import 'package:fireball/screen/UI/ahruTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AhruList extends StatefulWidget {
  const AhruList({super.key});

  @override
  State<AhruList> createState() => _AhruListState();
}

class _AhruListState extends State<AhruList> {
  @override
  Widget build(BuildContext context) {
    final ahrus = Provider.of<Iterable<Ahru>>(context) ?? [];
    return ListView.builder(
              itemCount: ahrus.length,
      itemBuilder: (context, index) {
          final ahruList = ahrus.toList();
          return Ahrutile(ahru: ahruList[index]);
    });
  }
}
