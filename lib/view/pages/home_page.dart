import 'package:flutter/material.dart';

import '../../model/responsemodel.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.data});
  final Requestapi data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Column()),
    );
  }
}
