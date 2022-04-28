import "dart:async";
import 'dart:convert';

import 'package:eventsource/publisher.dart';
import "package:shelf/shelf_io.dart" as io;
import 'package:shelf_eventsource/shelf_eventsource.dart';
import 'package:shelf_router/shelf_router.dart';

main() {
  var app = Router();

  app.get("/events", _handlerEventsWithoutUser);

  app.get("/events/<user>", _handlerEventsWithtUser);

  io.serve(app, "localhost", 8080);
}

_handlerEventsWithoutUser(dynamic r) {
  final publisher = EventSourcePublisher();
  generateEvents(publisher);
  var handler = eventSourceHandler(publisher);
  handler(r);
}

_handlerEventsWithtUser(dynamic request, String user) {
  final publisher = EventSourcePublisher();
  generateEvents(publisher, user: user);
  var handler = eventSourceHandler(publisher, channel: user);
  handler(request);
}

generateEvents(
  EventSourcePublisher publisher, {
  String? user,
}) {
  int id = 0;
  Timer.periodic(const Duration(milliseconds: 500), (timer) {
    var finished = id >= 20;

    final data = json.encode({
      'id': id,
      'message': 'event $id',
      'finished': finished,
      'user': user,
    });
    publisher.add(Event(data: data), channels: [user ?? '']);

    if (finished) {
      timer.cancel();

      publisher.close();
    }

    id++;
  });
}
