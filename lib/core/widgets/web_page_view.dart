
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart'; // For Android
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _webViewController;
  bool _isLoading = true;

  @override
  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;

            if (url.contains('whatsapp.com') ||
                url.startsWith('tel:') ||
                url.startsWith('mailto:')) {
              _launchExternalUrl(url);
              return NavigationDecision.prevent;
            }

            if (url.contains('/success')) {
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    // 🛠️ Delay setting Android-specific properties until after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_webViewController.platform is AndroidWebViewController) {
        final androidController =
        _webViewController.platform as AndroidWebViewController;

        androidController
          ..setMediaPlaybackRequiresUserGesture(false)
          ..setOnShowFileSelector(_onShowFileSelector);
      }
    });
  }

  Future<void> _launchExternalUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  }

  Future<List<String>> _onShowFileSelector(FileSelectorParams params) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null) {
        List<String> fileUris = result.files
            .where((file) => file.path != null)
            .map((file) => File(file.path!).uri.toString())
            .toList();

        return fileUris;
      } else {
        return [];
      }
    } catch (e) {
      print('Error picking files: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fill The Form"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _webViewController,
          ),
          if (_isLoading)
            const LinearProgressIndicator(
              backgroundColor: Colors.blue,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
        ],
      ),
    );
  }
}