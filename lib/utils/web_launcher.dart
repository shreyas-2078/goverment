import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'networks/toast_services/toast_services.dart';

class AppLauncher {
  static Future<void> openPhoneDialer({String? phoneNumber}) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ToastServices.error("Error", "Cannot open phone dialer.");
    }
  }

  static Future<void> openWhatsApp({required String phone}) async {
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');
    final uri = Uri.parse("https://wa.me/$cleanPhone");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      
      ToastServices.error("Error", "This number is not on WhatsApp.");
    }
  }
  static Future<void> openLocation(
      {String? query, double? latitude, double? longitude}) async {
    late final Uri uri;

    if (Platform.isAndroid) {
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$query';
      uri = Uri.parse(googleUrl);
    } else if (Platform.isIOS) {
      String appleUrl = 'https://maps.apple.com/?q=$query';
      uri = Uri.parse(appleUrl);
    } else {
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$query';
      uri = Uri.parse(googleUrl);
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ToastServices.error("Error", "Cannot open maps.");
    }
  }
  
}
