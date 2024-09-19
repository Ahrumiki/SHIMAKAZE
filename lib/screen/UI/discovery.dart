
import 'package:flutter/material.dart';

class DiscoveryTab extends StatelessWidget {
  const DiscoveryTab({super.key});

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: AppBar(
        title: const Text('Discovery'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Home TABBB'),
      ),
    );
  }
}