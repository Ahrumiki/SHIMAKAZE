import 'package:fireball/models/ahru.dart';
import 'package:flutter/material.dart';

class Ahrutile extends StatelessWidget {
  const Ahrutile({super.key, required this.ahru});
  final Ahru ahru;
  

  @override
  Widget build(BuildContext context) {
   
    return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Card(
          margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
                radius: 25, 
                backgroundColor: Colors.brown[ahru.strength],
                backgroundImage: const AssetImage('assets/coffee_icon.png'),
              ),
              title: Text(ahru.name),
              subtitle: Text('Take ${ahru.sugars} sugars:'),
          )
        ),
      );
  }
}
