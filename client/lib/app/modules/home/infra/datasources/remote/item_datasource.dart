import 'package:client/app/modules/home/infra/models/item_modal.dart';

import '../../../../../../commons/adapter/sse/enums/sse_enum.dart';
import '../../../../../../commons/adapter/sse/sse_adapter.dart';
import '../../../data/datasources/item_datasource_interface.dart';

class ItemDatasource implements IItemDatasource {
  final SseAdapter _sseAdapter;

  ItemDatasource({
    required SseAdapter sseAdapter,
  }) : _sseAdapter = sseAdapter;

  @override
  Stream<ItemModel> get() async* {
    final request = await _sseAdapter.connect(
      baseUrl: 'localhost:8080',
      path: '/events',
      method: SseMethod.GET,
      queryParameters: {},
      headers: {},
      data: {},
    );

    yield* request.stream.map(
      (data) {
        var result = ItemModel.fromJson(data);
        return result;
      },
    );
  }
}
