import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box('scanned_results');

    return Scaffold(
      appBar: AppBar(
        title: Text('Scan History'),
      ),
      body: ListView.builder(
        itemCount: box.values.length,
        itemBuilder: (context, index) {
          final result = box.getAt(index) as String;
          return ListTile(
            leading: QrImageView(
              data: result,
              version: QrVersions.auto,
              size: 50.0,
            ),
            title: Text(result),
            trailing: Icon(Icons.more_vert),
          );
        },
      ),
    );
  }
}
