import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoadingPage extends StatefulWidget {
  final VoidCallback onLoaded;
  const LoadingPage({super.key, required this.onLoaded});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  double _progress = 0.0;
  final int dataFreshnessSeconds = 7 * 24 * 60 * 60; // 7 days

  @override
  void initState() {
    super.initState();
    _maybeLoadData();
  }

  Future<void> _maybeLoadData() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDownload = prefs.getInt('lastDownloadLottoData') ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    if (now - lastDownload < dataFreshnessSeconds) {
      widget.onLoaded();
      return;
    }
    await _fetchAndSaveLottoData();
    prefs.setInt('lastDownloadLottoData', now);
    widget.onLoaded();
  }

  Future<void> _fetchAndSaveLottoData() async {
    final files = [
      ['getDailyLottoDataByDateRange', 'daily_lotto.json'],
      ['getLottoDataByDateRange', 'lotto.json'],
      ['getLottoPlusDataByDateRange', 'lotto_plus.json'],
      ['getLottoPlusTwoDataByDateRange', 'lotto_plus_two.json'],
      ['getPowerballDataByDateRange', 'powerball.json'],
      ['getPowerballPlusDataByDateRange', 'powerball_plus.json'],
    ];
    for (int i = 0; i < files.length; i++) {
      await _downloadAndSave(files[i][0], files[i][1]);
      setState(() => _progress = (i + 1) / files.length);
    }
  }

  Future<void> _downloadAndSave(String fn, String filename) async {
    final url = 'https://us-central1-leaplottoza.cloudfunctions.net/$fn';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$filename');
      await file.writeAsString(response.body, flush: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBC700),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 44),
                  child: Text(
                    'Lotto Dash',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'images/LOTTO_DASH.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 400,
                      child: Progress(
                        progress: (_progress * 100).clamp(0, 100),
                        min: 0,
                        max: 100,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "${(_progress * 100).toStringAsFixed(0)}% Loading Lotto Data...",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
