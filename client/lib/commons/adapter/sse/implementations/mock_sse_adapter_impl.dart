import 'dart:async';

import '../enums/sse_enum.dart';
import '../sse_adapter.dart';
import 'mock/mock.dart';

class MockSseAdapterImpl implements SseAdapter {
  final kTimeout = const Duration(seconds: 30);
  late final StreamController<Map> _streamController;

  _mock() async {
    _streamController = StreamController<Map>();
    await Future.delayed(const Duration(seconds: 2));
    _streamController.add(response1);
    await Future.delayed(const Duration(seconds: 2));
    _streamController.add(response2);
    await Future.delayed(const Duration(seconds: 3));
    _streamController.add(response3);
    await Future.delayed(const Duration(seconds: 6));
    _streamController.add(response4);
    await Future.delayed(const Duration(seconds: 6));
    _streamController.add(response5);
  }

  @override
  Future<SseAdapter> connect({
    required String baseUrl,
    String? relativePath,
    required String path,
    String scheme = 'https',
    bool closeOnError = true,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    SseMethod method = SseMethod.GET,
  }) async {
    _mock();
    return this;
  }

  @override
  Stream get stream => _streamController.stream.timeout(kTimeout);

  @override
  bool isClosed() => _streamController.isClosed;

  @override
  void close() {}
}
