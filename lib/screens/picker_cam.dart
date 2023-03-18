import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';


 ElevatedButton(
              onPressed: () async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                setState(() {
                  if (res is String) {
                    result = res;
                  }
                });
              },
              child: const Text('Open Scanner'),
            )
