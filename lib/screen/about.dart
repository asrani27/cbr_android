import 'package:flutter/material.dart';

class about extends StatefulWidget {
  const about({super.key});

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Tentang Aplikasi'),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TES KEPRIBADIAN ',
              style: TextStyle(fontSize: 20, color: Colors.purple[800]),
            ),
            Text(
              'METODE CBR',
              style: TextStyle(fontSize: 18, color: Colors.purple[500]),
            ),
            Text('Versi 1.1.0'),
          ],
        ),
      ),
    );
  }
}
