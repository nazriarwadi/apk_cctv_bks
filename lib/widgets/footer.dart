// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '© 2021 CCTV BENGKALIS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8.0),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Designed by Team IT',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                TextSpan(
                  text: ' Diskominfotik Kabupaten Bengkalis',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _launchURL('https://diskominfotik.bengkaliskab.go.id'),
                ),
                const TextSpan(
                  text: ' | ',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const TextSpan(
                  text: 'Powered by ',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                TextSpan(
                  text: 'Bengkaliskab.go.id',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _launchURL('https://bengkaliskab.go.id'),
                ),
                const TextSpan(
                  text: ' | ',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                TextSpan(
                  text: 'YouTube.com',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => _launchURL('https://www.youtube.com/@CCTVBengkalis'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
