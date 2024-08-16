import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'intialAds.dart';
import 'result.dart';
import 'package:hive/hive.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final InterstitialAdManager _interstitialAdManager = InterstitialAdManager();

  bool isFlashon = false;
  final controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  @override
  void initState() {
    controller.start();
    super.initState();
  }

  @override
  Future<void> dispose() async {
    controller.dispose();
    super.dispose();
  }

  Future<void> _saveResult(String result) async {
    var box = Hive.box('scanned_results');
    await box.add(result);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: (capture) {
            Future.delayed(Duration(milliseconds: 500)).then(
              (value) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  debugPrint('QR Found! ${barcode.rawValue}');
                  _interstitialAdManager.loadInterstitialAd();
                  _saveResult(barcode.rawValue!);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ResultScreen(resultText: '${barcode.rawValue}');
                      },
                    ),
                  ).then((value) => controller.start());
                }
                controller.stop();
              },
            );
          },
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          // drawer: Padding(
          //   padding: EdgeInsets.only(top: 100),
          // child: Drawer(
          //   width: 200,
          //   backgroundColor: Colors.white,
          //   child: ListView(
          //     padding: EdgeInsets.zero,
          //     children: <Widget>[
          //       // DrawerHeader(
          //       //   child: Text('Drawer Header'),
          //       //   decoration: BoxDecoration(
          //       //     color: Colors.blue,
          //       //   ),
          //       // ),
          //       ListTile(
          //         title: Text('Scan'),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const Homescreen()),
          //           );
          //         },
          //       ),
          //       ListTile(
          //         title: Text('Scan image'),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const Homescreen()),
          //           );
          //         },
          //       ),
          //       ListTile(
          //         title: Text('History'),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(builder: (context) => HistoryPage()),
          //           );
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          // ),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, // Change this to the color you want
            ),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              "QR Scanner ",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isFlashon = !isFlashon;
                    });
                    controller.toggleTorch();
                  },
                  icon: Icon(
                    isFlashon ? Icons.flash_off : Icons.flash_on,
                    color: Colors.white,
                  ))
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  height: 250,
                  width: 250,
                  // color: Colors.red,
                  // child: Text(""),
                ),
              )
            ],
          ),
          // bottomNavigationBar: SizedBox(
          //   height: 50,
          //   child: AdWidget(
          //     ad: AdmobHelper.getBannerAd()..load(),
          //     key: UniqueKey(),
          //   ),
          // ),
        ),
      ],
    );
  }
}
