import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatelessWidget {
  final String deepLink = "https://google.com/app"; // Replace with your domain

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan QR to Open App")),
      body: Center(
        child: QrImageView(
          data: deepLink,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
