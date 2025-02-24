import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:hotelorg/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;
  String? _deepLink;

  @override
  void initState() {
    super.initState();
    initDeepLink();
  }

  // Function to listen to deep links
  void initDeepLink() async {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        setState(() {
          _deepLink = uri.toString();
        });
        print("Deep Link Received: $_deepLink");

        // Navigate based on deep link (modify as needed)
        if (uri.path == "/app") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      }
    }, onError: (err) {
      print("Error receiving deep link: $err");
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Deep Linking Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(), // Default screen
    );
  }
}
