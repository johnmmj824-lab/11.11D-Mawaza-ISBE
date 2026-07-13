import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MiningScreen extends StatefulWidget {
  @override
  _MiningScreenState createState() => _MiningScreenState();
}

class _MiningScreenState extends State<MiningScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  Timer? _timer;
  int xp = 0;
  bool isMining = false;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    _auth.authStateChanges().listen((User? u) {
      setState(() { user = u; });
    });
  }

  void startMining() async {
    if (user == null) {
      // TODO: Add login flow
      return;
    }
    setState(() { isMining = true; });
    _timer = Timer(Duration(minutes: 5), () {
      setState(() { 
        xp += 50;
        isMining = false; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('11.11D Mawaza Mining ⛏️')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user?.email ?? "Soul"}'),
            Text('XP: $xp', style: TextStyle(fontSize: 48, color: Colors.amber)),
            ElevatedButton(
              onPressed: isMining ? null : startMining,
              child: Text(isMining ? 'Mining the Light...' : 'Mine XP (5 min)'),
            ),
          ],
        ),
      ),
    );
  }
}