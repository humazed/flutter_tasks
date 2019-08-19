import 'dart:async';

import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';

class QrScannerScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  QrScannerScreen(this.cameras);

  static Future<String> scanQrCode(BuildContext context) async {
    try {
      final cameras = await availableCameras();

      var results = await Navigator.of(context).push(
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) {
            return QrScannerScreen(cameras);
          },
        ),
      );

      if (results != null && results.containsKey('pickedQrCode')) {
        return results['pickedQrCode'];
      } else {
        return null;
      }
    } on QRReaderException catch (e) {
      d(e.code + e.description);
      return null;
    }
  }

  @override
  QrScannerScreenState createState() => QrScannerScreenState();
}

class QrScannerScreenState extends State<QrScannerScreen>
    with SingleTickerProviderStateMixin {
  QRReaderController controller;
  AnimationController animationController;
  Animation<double> verticalPosition;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    animationController.addListener(() {
      this.setState(() {});
    });
    animationController.forward();
    verticalPosition = Tween<double>(begin: 0, end: 300).animate(
        CurvedAnimation(parent: animationController, curve: Curves.linear))
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          animationController.reverse();
        } else if (state == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    // pick the first available camera
    onNewCameraSelected(widget.cameras[0]);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'No camera selected',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio / .9,
        child: QRReaderPreview(controller),
      );
    }
  }

  void onCodeRead(dynamic value) {
    d('"value = [$value]"');
    Navigator.of(context).pop({'pickedQrCode': value});
    // ... do something
    // wait 5 seconds then start scanning again.
    Future.delayed(const Duration(seconds: 5), controller.startScanning);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = QRReaderController(cameraDescription, ResolutionPreset.low,
        [CodeFormat.qr, CodeFormat.pdf417], onCodeRead);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        errorToast('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on QRReaderException catch (e) {
      d(e.code + e.description);
      errorToast('Error: ${e.code}\n${e.description}');
    }

    if (mounted) {
      setState(() {});
      controller.startScanning();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New'),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 33),
              Text(
                'Scan Qr Code',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 8),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _cameraPreviewWidget(),
                    ),
                  ),
                ),
              ),
              Text(
                'Hold on your phone',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Center(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF33E1FF), width: 2),
                    ),
                  ),
                ),
                Positioned(
                  top: verticalPosition.value,
                  child: Container(
                    width: 300,
                    height: 2,
                    color: Color(0xFF33E1FF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
