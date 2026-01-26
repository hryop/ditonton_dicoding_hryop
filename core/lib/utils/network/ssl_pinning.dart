import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpSSLPinning {
  static Future<http.Client> get _instance async =>
      _clientInstance ??= await createLEClient();
  static http.Client? _clientInstance;
  static http.Client get client => _clientInstance ?? http.Client();
  static Future<void> init() async {
    _clientInstance = await _instance;
  }

  static Future<http.Client> createLEClient() async {
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    try {
      final bytes = await rootBundle.load('certificates/ditonton_api_certificate.pem');
      securityContext.setTrustedCertificatesBytes(bytes.buffer.asUint8List());
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        log('error : certificated already trusted');
      } else {
        log('exception $e');
        rethrow;
      }
    } catch (e) {
      log('unexpected error $e');
      rethrow;
    }
    HttpClient client = HttpClient(context: securityContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    IOClient ioClient = IOClient(client);
    return ioClient;
  }
}