import 'enums/sse_enum.dart';

abstract class SseAdapter {
  Future<SseAdapter> connect({
    required String baseUrl,
    String? relativePath,
    required String path,
    String scheme = 'http',
    bool closeOnError = true,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Map<String, dynamic> data,
    SseMethod method = SseMethod.GET,
  });

  Stream get stream;

  bool isClosed();

  void close();
}
