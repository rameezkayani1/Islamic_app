import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/QRScanner/homescreen.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'banneads.dart';
import 'intialAds.dart';

class ResultScreen extends StatefulWidget {
  final String resultText;

  ResultScreen({super.key, required this.resultText});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // String? get resultText => null;
  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("QR Scenner"),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Homescreen()),
            );
            // * Write listener code here */
          },
          child: Icon(
            Icons.arrow_back_rounded, // add custom icons also
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: AdWidget(
              ad: AdmobHelper.getBannerAd()..load(),
              key: UniqueKey(),
            ),
          ),
          QrImageView(
            data: widget.resultText,
            version: QrVersions.auto,
            size: 200.0,
          ),
          Center(
            child: Container(
              child: Text(widget.resultText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black)),
            ),
          ),
          Container(
            color: Colors.blue,

            height: 48,
            width: MediaQuery.of(context).size.width - 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                _interstitialAdManager.loadInterstitialAd();

                Clipboard.setData(ClipboardData(text: widget.resultText));
              },
              child: Text("copy",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white)),
            ),
            // color: Colors.blue,
          ),
          Expanded(
            flex: 1,
            // height: 50,
            // width: MediaQuery.of(context).size.width,
            child: AdWidget(
              ad: AdmobHelper.getBannerAd()..load(),
              key: UniqueKey(),
            ),
          ),
        ],
      ),
    );
  }
}
