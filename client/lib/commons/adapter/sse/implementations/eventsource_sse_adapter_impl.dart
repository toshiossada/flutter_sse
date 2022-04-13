import 'dart:async';
import 'dart:convert';

import 'package:eventsource/eventsource.dart';

import '../enums/sse_enum.dart';
import '../sse_adapter.dart';

class EventsourceSseAdapterImpl implements SseAdapter {
  final kTimeout = const Duration(seconds: 30);
  late StreamController<Map> _streamController;

  _url({
    required String baseUrl,
    String? relativePath,
    String? path,
    String scheme = 'http',
    Map<String, dynamic>? queryParameters,
  }) {
    final listQueryString = <String>[];
    var q = '';
    queryParameters?.forEach((key, value) {
      listQueryString.add('$key=$value');
    });
    if (listQueryString.isNotEmpty) q = '?${listQueryString.join('&')}';

    if (scheme.isNotEmpty) {
      baseUrl = baseUrl.replaceAll('http://', '').replaceAll('https://', '');
      baseUrl = '$scheme://$baseUrl';
    }
    return '$baseUrl${relativePath ?? ''}${path ?? ''}$q';
  }

  _body(Map<String, dynamic>? data) {
    if (data == null) return null;
    return json.encode(data);
  }

  @override
  Future<SseAdapter> connect({
    required String baseUrl,
    String? relativePath,
    required String path,
    String scheme = 'http',
    bool closeOnError = true,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    SseMethod method = SseMethod.GET,
  }) async {
    try {
      late final EventSource _eventSources;
      final url = _url(
        baseUrl: baseUrl,
        relativePath: relativePath,
        path: path,
        queryParameters: queryParameters,
        scheme: scheme,
      );
      final body = _body(data);
      _streamController = StreamController<Map>();
      _eventSources = await EventSource.connect(
        url,
        headers: headers,
        method: method.value,
        body: body,
      );

      _eventSources.listen((Event event) {
        try {
          if (!_streamController.isClosed && event.data != null) {
            var dataJson = json.decode(event.data!);
            _streamController.add(dataJson);
          }
        } catch (e) {
          rethrow;
        }
      }).onError((e) {
        _streamController.addError(Exception("Erro SSE"));
        if (closeOnError) close();
      });

      return this;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream get stream => _streamController.stream.timeout(kTimeout);

  @override
  bool isClosed() => _streamController.isClosed;

  @override
  void close() {
    _streamController.close();
  }
}
