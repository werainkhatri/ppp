import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppp/utils/functions.dart';
import 'package:rive/rive.dart';

/// An example showing how to drive a StateMachine via a trigger and number
/// input.
class LiquidDownload extends StatefulWidget {
  const LiquidDownload({Key? key}) : super(key: key);

  @override
  _LiquidDownloadState createState() => _LiquidDownloadState();
}

class _LiquidDownloadState extends State<LiquidDownload> {
  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<bool>? _start;
  SMIInput<double>? _progress;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/liquid_download.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(artboard, 'Download');
        if (controller != null) {
          artboard.addController(controller);
          _start = controller.findInput('Download');
          _progress = controller.findInput('Progress');
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: _riveArtboard == null
              ? const SizedBox()
              : GestureDetector(
                  onTapDown: (_) => _start?.value = true,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Text(
                        'Press to activate, slide for progress...',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Slider(
                        value: _progress!.value,
                        min: 0,
                        max: 100,
                        label: _progress!.value.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _progress!.value = value;
                          });
                        },
                      ),
                      Expanded(
                        child: Rive(
                          artboard: _riveArtboard!,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        Positioned(
          right: 50,
          bottom: 50,
          child: IconButton(
            iconSize: 40,
            onPressed: () {
              F.openUrl('https://github.com/rive-app/rive-flutter/tree/master/example');
            },
            icon: const Icon(Icons.code),
          ),
        )
      ],
    );
  }
}
